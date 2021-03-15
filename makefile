
getllvm:
	git checkout 7ee96429a0b057bcc97331a6a762fc3cd00aed61

macos:
	(cd build; cmake -G "Ninja" \
	-DCMAKE_INSTALL_PREFIX=/opt/llvm-project-tot \
	-DLIBOMP_ARCH=x86_64 \
	-DLLVM_ABI_BREAKING_CHECKS=FORCE_OFF \
	-DLINK_POLLY_INTO_TOOLS=ON \
	-DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON \
	-DLLVM_BUILD_LLVM_DYLIB=ON \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_ENABLE_EH=ON \
	-DLLVM_ENABLE_FFI=ON \
	-DLLVM_ENABLE_LIBCXX=ON \
	-DLLVM_ENABLE_RTTI=ON \
	-DLLVM_INCLUDE_DOCS=OFF \
	-DLLVM_INSTALL_UTILS=ON \
	-DLLVM_OPTIMIZED_TABLEGEN=ON \
	-DLLVM_TARGETS_TO_BUILD=all \
	-DLLVM_ENABLE_PROJECTS="libcxx;libcxxabi;clang" \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DWITH_POLLY=ON \
	-DFFI_INCLUDE_DIR=/usr/local/Cellar/libffi/3.2.1/lib/libffi-3.2.1/include \
	-DFFI_LIBRARY_DIR=/usr/local/Cellar/libffi/3.2.1/lib \
	-DLLVM_CREATE_XCODE_TOOLCHAIN=ON \
	-DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
	-DLLDB_DISABLE_PYTHON=0 \
	-DLIBOMP_INSTALL_ALIASES=OFF ../llvm )



## Do not use 	-DLLVM_ENABLE_LIBCXX=ON  on linux
# libc++ is not 100% complete on GNU/Linux, and there's no real advantage to using it when
# libstdc++ is more complete. Also, if you want to link to any other libraries written
# in C++ they will almost certainly have been built with libstdc++ so you'll need to link with that too to use them.

linux:
	(cd build; \
	CC=/usr/bin/clang-9 CXX=/usr/bin/clang++-9 cmake -G "Ninja" \
	-DCMAKE_INSTALL_PREFIX=/opt/llvm-tot \
	-DLIBOMP_ARCH=x86_64 \
	-DLLVM_ABI_BREAKING_CHECKS=FORCE_OFF \
	-DCLANG_DEFAULT_UNWINDLIB="libunwind" \
	-DLINK_POLLY_INTO_TOOLS=ON \
	-DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON \
	-DLLVM_BUILD_LLVM_DYLIB=ON \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_ENABLE_EH=ON \
	-DLLVM_ENABLE_RTTI=ON \
	-DLLVM_INCLUDE_DOCS=OFF \
	-DLLVM_INSTALL_UTILS=ON \
	-DLLVM_OPTIMIZED_TABLEGEN=ON \
	-DLLVM_TARGETS_TO_BUILD="X86" \
	-DLLVM_ENABLE_PROJECTS="libunwind;clang" \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DWITH_POLLY=ON \
	-DLIBOMP_INSTALL_ALIASES=OFF ../llvm )


clean:
	rm -rf ./build/*
