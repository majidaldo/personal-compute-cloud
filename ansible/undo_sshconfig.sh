#!/bin/sh
#rm ~/.ssh/known_hosts
#rm -r ~/.ssh/config.d
find ~/.ssh/config.d/. -not -name '10-perso' -print0  | xargs -0 rm
rm -f ~/.ssh/config

