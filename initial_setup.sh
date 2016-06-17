#!/bin/sh
if [ ! -f ".gitignore" ]; 
then
  echo "setting up git"
  #Then this is the first time
  git init 
  git remote add origin git@github.com:rbur004/versioncheck.git 
  cat > .ignore <<EOF
doc/
gitdoc/
pkg/
Private/
test_data/*.out
.autotest
EOF
fi

mkdir -p gitdoc
cd gitdoc
if [ ! -f ".gitignore" ]; 
then
  echo "setting up gitdoc"
  git init 
  git remote add origin git@github.com:rbur004/versioncheck.git 
  git fetch origin
  #next line fails in this script, but works when run manually? 
  git checkout --orphan gh-pages
  touch .gitignore
fi

