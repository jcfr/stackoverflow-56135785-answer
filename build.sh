#!/bin/bash

set -xeu
set -o pipefail

script_dir=$(cd $(dirname $0) || exit 1; pwd)

project_name=FooBarLib
archive_name=${project_name}

# cleanup ${project_name}-build
cd $script_dir
rm -rf ${project_name}-build
mkdir ${project_name}-build
cd ${project_name}-build

# configure, build and package ${project_name}
cmake ../${project_name}
make
#make package
cpack -G TGZ

# extract ${project_name} archive
cd $script_dir
rm -rf ${project_name}-install
mkdir ${project_name}-install
cd ${project_name}-install
tar -xvzf ../${project_name}-build/${archive_name}-1.2.3.tar.gz

# cleanup useFoo-build
cd $script_dir
rm -rf useFoo-build
mkdir useFoo-build
cd useFoo-build

# configure useFoo
cmake -D${project_name}_DIR=$script_dir/${project_name}-install/lib/cmake/${project_name}/ ../useFoo

cat foobar-gen
