import yaml
import re


"""
autmates filling out a coreos cloudconfig file from a 'master'
cloud config file
"""

class EnvDict(dict):
    @staticmethod
    def chkvar(var):
        if var[0].isalpha() is not True:
            raise ValueError("have to begin w/ letter")
    @staticmethod
    def replacementtoken(var):
        return '${'+var.upper()+'}'
    @staticmethod
    def unreplacementtoken(var):
        var=var.strip()
        var=var.replace('$','')
        var=var.replace('{','')
        var=var.replace('}','')
        EnvDict.chkvar(var)
        var=var.upper()
        return var
    
    def __setitem__(self, k, v):
        k=EnvDict.unreplacementtoken(k)
        if v is None: v=EnvDict.replacementtoken(k)
        v=str(v)
        return super(EnvDict,self).__setitem__(k,v)
    def __getitem__(self, k):
        k=EnvDict.unreplacementtoken(k)
        return super(EnvDict,self).__getitem__((k))
        




#library=yaml.load(open('user-data.temp.yaml').read())


#here i'm trying to id parts of the yml file that are in lists
#each list item has an identifying item 'header' as follows
coreos_sectionIDs={'write_files': 'path'
                   ,'users':'name'
                   ,'coreos.units':'name'}

def getFromDict(dataDict, mapList):
    """gets a value from a nested dictionary"""
    return reduce(lambda d, k: d[k], mapList, dataDict)
def getFromYml(*args):
    args=list(args)
    args[1]=args[1].split('.')
    return getFromDict(*args)
def _dot2brackets(dotstr):
    #hack enabler
    alibrary=dotstr.split('.')
    brackets=''
    for k in alibrary:
        if k=='': continue
        brackets+="['"+k+"']"
    return brackets

        
def get_ymlitem(section,ID, ymlo,sectionIDs=coreos_sectionIDs):
    """given a yml obj, find the list item"""

    if section not in sectionIDs:
        raise ValueError('section not identified')
    #have to loop through a list
    for anitem in getFromYml(ymlo,section):#list
        if anitem[sectionIDs[section]]==ID:
            return anitem

#catches $V ${V} $VAR ${VAR} $VAR_3 ${VAR3_4}
var_regex=ur'(\${*[A-Z]+[A-Z_0-9]+}*|\${*[A-Z]}*)'
        
def get_vars(astr):
    """gets $VAR and ${VAR}. Only considering caps"""
    astr=repl_myassignments(astr)
    p= re.compile(var_regex, re.VERBOSE)
    vars = re.findall(p, astr)
    vars = [EnvDict.unreplacementtoken(avar) for avar in vars]
    return set(vars)

def repl_myassignments(astr):
    """if somewhere i put VAR== then make it VAR=$VAR"""
    p = re.compile(ur'[A-Z_]+[A-Z_0-9]?==', re.VERBOSE)
    #vars = re.findall(p, astr)
    def repl(match):
        s=match.start()
        e=match.end()
        var=match.string[s:e-2]
        return var+'=='+'$'+var
    return p.sub(repl,astr)


def subs(astr,subs_dict):
    """nice behavior: get the keys from the str with get_vars
    then envdict.fromkeys then give it to this func"""
    sd=EnvDict()
    sd.update(subs_dict); 
    subs_dict=sd
    astr=repl_myassignments(astr)
    p = re.compile(var_regex, re.VERBOSE)
    def repl(match):
        s=match.start()
        e=match.end()
        var=EnvDict.unreplacementtoken(match.string[s:e])
        try:
            return subs_dict[var]
        except:
            subs_dict[var]=None
            return subs_dict[var]
    return p.sub(repl,astr)


def read_envfile(envfile):
    """makes a dict out of entries in an env file"""
    envs={}
    for aline in envfile:
        if aline[0]=='#': continue
        if '=' not in aline: continue
        var,val=aline.split('=')
        var=var.strip()
        val=val.strip()
        envs[var]=val
    return envs


def assemble_cloudconfig( library_file,  appyml_file, envfiles=[]  ):
    """
    library_file: the 'master'/'template' cloud config file
    appyml_file: a, perhaps smaller, filled out cloud config file
    envfiles: list of environment variables. # comment allowed
    """
    
    #make one env dict. later env file entries are overridden
    envs={}
    ymllibo=yaml.load(library_file)
    for aenvf in envfiles:
        envsf=read_envfile(aenvf)
        for k,v in envsf.iteritems(): envs[k]=v
    
    #put together
    ymlo=yaml.load(appyml_file)
    for asec in coreos_sectionIDs:
        try: appitems=getFromYml(ymlo,asec)
        #eg [{'name':docker.service'}...{'name':etcd.service} ]
        except: continue #this section doesn not exist
        secid=coreos_sectionIDs[asec] #'name'
        items=[]
        for anitem in appitems:
            #get the item from 'library/template'
            libraryitem=get_ymlitem(asec,anitem[secid],ymllibo)
            #          = {'name':etcd.service,contents: ...}
            #HACKKK
            acc=_dot2brackets(asec)
            #print libraryitem
            #return libraryitem
            items.append(libraryitem)
        #..and put it in the 'app'
        exec('ymlo'+acc+'=items')

    return '#cloud-config\n\n\n'+\
        subs(yaml.dump(ymlo,default_flow_style=False),envs)
    

if __name__=='x__main__':
    
    import sys
    
    if len(sys.argv[1:])<2: print 'need more arguments'
    
