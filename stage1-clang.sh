#/bin/bash
set -e
PROSPERODEV=/usr/local/prosperodev
PROC_NR=$(getconf _NPROCESSORS_ONLN)

REPO_URL="https://github.com/llvm/llvm-project"
REPO_FOLDER="llvm-project"
REPO_PROVISIONAL_COMMIT="30f22429d38944e126db75296a1ffc6c12c7b87a"
if test ! -d "$REPO_FOLDER"; then
	git clone $REPO_URL && cd $REPO_FOLDER || exit 1
	git checkout ${REPO_PROVISIONAL_COMMIT}||exit 1
	patch --strip=1 --input=../unofficial_prospero_llvm_15.0.patch
fi
cmake \
    -G "Unix Makefiles" \
    -S llvm -B build \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_INSTALL_PREFIX=${PROSPERODEV}/ \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-sie-ps5 \
    || exit 1
    

## Enter in build folder
cd build || exit 1
## Compile and install.
make --quiet -j $PROC_NR clean   || { exit 1; }
make --quiet -j $PROC_NR CFLAGS="$CFLAGS -I/opt/local/include -O2" LDFLAGS="$LDFLAGS -L/opt/local/lib"|| { exit 1; }
make --quiet -j $PROC_NR install || { exit 1; }
make --quiet -j $PROC_NR clean   || { exit 1; }
