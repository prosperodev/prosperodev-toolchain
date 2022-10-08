#!/bin/bash
# Script phase by fjtrujy

#/bin/bash
set -e
PROC_NR=$(getconf _NPROCESSORS_ONLN)

REPO_URL="https://github.com/llvm/llvm-project"
REPO_FOLDER="llvm-project"
if test ! -d "$REPO_FOLDER"; then
	git clone $REPO_URL && cd $REPO_FOLDER || exit 1
fi

## Extra FLAGS
EXTRA_FLAGS=""

## Check if MacPort installed
if [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -d "/opt/local/lib" ]; then
		EXTRA_FLAGS="CFLAGS=-I/opt/local/include $CFLAGS LDFLAGS=-L/opt/local/lib $LDFLAGS"
	fi
fi

cmake \
    -G "Unix Makefiles" \
    -S llvm -B build \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_ENABLE_PROJECTS="clang;lld" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_INSTALL_PREFIX=${PROSPERODEV}/ \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-sie-ps5 \
    || exit 1
    

## Enter in build folder
cd build || exit 1

## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR $EXTRA_FLAGS || { exit 1; }
make --quiet -j $PROC_NR install || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }
