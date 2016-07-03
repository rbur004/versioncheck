#!/bin/sh
#Copy up to rubygem.org
VERSION="1.0.0"
git tag -a ${VERSION} -m "Gem release ${VERSION}"
/usr/local/bin/rake release VERSION=${VERSION} #--trace
