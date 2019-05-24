#!/bin/sh

rm -rf target
mkdir target
cd target
cmake .. &&
make &&
cpack -G TGZ
if [ $? -ne 0 ]; then
   echo "doh!"
   exit 1
fi

cd ..
rm -rf install
mkdir install
cd install
tar -xvzf ../target/foobar-1.2.3.tar.gz
cp ../useFoo.cmake CMakeLists.txt
export CMAKE_PREFIX_PATH=`pwd`/opt/foobar/lib/cmake:`pwd`/opt/foobar/lib/cmake/foobar
cmake .
if [ $? -ne 0 ]; then
   echo "doh!"
   exit 1
fi
cat foobar-gen
