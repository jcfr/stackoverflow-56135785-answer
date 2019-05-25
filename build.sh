#!/bin/bash

set -xeu
set -o pipefail

script_dir=$(cd $(dirname $0) || exit 1; pwd)

# cleanup foobar-build
cd $script_dir
rm -rf foobar-build
mkdir foobar-build
cd foobar-build

# configure, build and package foobar
cmake ../foobar
make
#make package
cpack -G TGZ

# extract foobar archive
cd $script_dir
rm -rf foobar-install
mkdir foobar-install
cd foobar-install
tar -xvzf ../foobar-build/foobar-1.2.3.tar.gz

# cleanup useFoo-build
cd $script_dir
rm -rf useFoo-build
mkdir useFoo-build
cd useFoo-build

# configure useFoo
cmake -Dfoobar_DIR=$script_dir/foobar-install/lib/cmake/foobar/ ../useFoo

cat foobar-gen
