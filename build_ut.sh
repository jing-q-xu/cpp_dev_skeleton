#!/bin/bash

ROOT_FOLDER=$PWD
rm -rf build
rm -rf coverage
mkdir coverage

cmake -Bbuild -DBUILD_UT=ON -DCMAKE_BUILD_TYPE=Debug
cd build
make install
# cd ..
ctest
# EXCLUDE_DIR='-e ../src/sub1/test -e ../src/sub2/test -e 
# gcovr --gcov-ignore-parse-errors --xml -r ${ROOT_FOLDER}/src -b -p --object-directory='.' ${EXCLUDE_DIR} -o code_coverage.xml
gcovr --xml -r ${ROOT_FOLDER}/src -b -p --object-directory='.' ${EXCLUDE_DIR} -o code_coverage.xml
ctest ARGS --output-on-failure -T test || true
