#!/bin/sh
#create doc
/usr/local/bin/rake docs
cp -r doc/* gitdoc
rm -rf doc
( cd gitdoc; git add . ; git commit -a --allow-empty-message -m ""; git push origin gh-pages )
