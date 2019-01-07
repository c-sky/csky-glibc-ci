ROOT_PATH=`pwd`
rm output/build/glibc -rf
mkdir -p output/build/glibc
tar -xf output/images/glibc.tar.xz -C output/build/glibc
mkdir -p output/build/glibc/build
cd output/build/glibc/build
sed -i "s/tst-mallocfork2//g" ../malloc/Makefile
sed -i "s/tst-mallocfork//g" ../malloc/Makefile
sed -i "s/tst-clone3//g" ../sysdeps/unix/sysv/linux/Makefile
PATH="$ROOT_PATH/output/host/bin:$ROOT_PATH/output/host/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin" AR="$ROOT_PATH/output/host/bin/csky-linux--ar" AS="$ROOT_PATH/output/host/bin/csky-linux-as" LD="$ROOT_PATH/output/host/bin/csky-linux-ld" NM="$ROOT_PATH/output/host/bin/csky-linux-nm" CC="$ROOT_PATH/output/host/bin/csky-linux-gcc" GCC="$ROOT_PATH/output/host/bin/csky-linux-gcc" CPP="$ROOT_PATH/output/host/bin/csky-linux-cpp" CXX="$ROOT_PATH/output/host/bin/csky-linux-g++" FC="$ROOT_PATH/output/host/bin/csky-linux-gfortran" F77="$ROOT_PATH/output/host/bin/csky-linux-gfortran" RANLIB="$ROOT_PATH/output/host/bin/csky-linux-ranlib" READELF="$ROOT_PATH/output/host/bin/csky-linux-readelf" STRIP="$ROOT_PATH/output/host/bin/csky-linux-strip" OBJCOPY="$ROOT_PATH/output/host/bin/csky-linux-objcopy" OBJDUMP="$ROOT_PATH/output/host/bin/csky-linux-objdump" AR_FOR_BUILD="/usr/bin/ar" AS_FOR_BUILD="/usr/bin/as" CC_FOR_BUILD="/usr/bin/gcc" GCC_FOR_BUILD="/usr/bin/gcc" CXX_FOR_BUILD="/usr/bin/g++" LD_FOR_BUILD="/usr/bin/ld" CPPFLAGS_FOR_BUILD="-I$ROOT_PATH/output/host/include" CFLAGS_FOR_BUILD="-O2 -I$ROOT_PATH/output/host/include" CXXFLAGS_FOR_BUILD="-O2 -I$ROOT_PATH/output/host/include" LDFLAGS_FOR_BUILD="-L$ROOT_PATH/output/host/lib -Wl,-rpath,$ROOT_PATH/output/host/lib" FCFLAGS_FOR_BUILD="" DEFAULT_ASSEMBLER="$ROOT_PATH/output/host/bin/csky-linux-as" DEFAULT_LINKER="$ROOT_PATH/output/host/bin/csky-linux-ld" CPPFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O2 -g2" CXXFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O2 -g2" LDFLAGS="" FCFLAGS=" -O2 -g2" FFLAGS=" -O2 -g2" PKG_CONFIG="$ROOT_PATH/output/host/bin/pkg-config" STAGING_DIR="$ROOT_PATH/output/host/csky-linux/sysroot" INTLTOOL_PERL=/usr/bin/perl CFLAGS="-O2 -g" CPPFLAGS="" CXXFLAGS="-O2 -g" /bin/bash $ROOT_PATH/output/build/glibc/configure ac_cv_path_BASH_SHELL=/bin/bash libc_cv_forced_unwind=yes libc_cv_ssp=no --target=csky-linux- --host=csky-linux --build=x86_64-pc-linux-gnu --prefix=/usr --enable-shared --with-fp  --with-pkgversion="Buildroot" --without-cvs --without-gd --enable-obsolete-rpc --with-headers=$ROOT_PATH/output/host/csky*linux*/sysroot/usr/include
make > make.log
make check > make_check.log
cd -
output/host/csky-glibc-ci/make-check.sh&
output/host/csky-qemu/bin/qemu-system-cskyv2 -machine virt -cpu ck810f -kernel output/images/vmlinux -dtb output/images/qemu_glibc_ci.dtb -nographic -net nic -net tap,ifname=tap0
