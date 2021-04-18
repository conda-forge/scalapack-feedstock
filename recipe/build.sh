#!/bin/sh

export FC=mpifort
export CC=mpicc
export OPAL_PREFIX=$PREFIX

# remove this in next version update where this is fixed
sed -i.bak "s/ifort/dummy/g" CMakeLists.txt

mkdir build && cd build
cmake ${CMAKE_ARGS} \
    $EXTRA_CMAKE \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_PREFIX_PATH="$PREFIX" \
    -DCMAKE_BUILD_TYPE=Release \
    .. || (cat CMakeFiles/CMakeOutput.log && cat CMakeFiles/CMakeError.log && exit 1)

make install -j${CPU_COUNT}
