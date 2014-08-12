require 'formula'

class CfGcc < Formula
  homepage "http://gcc.gnu.org"
  url "http://ftpmirror.gnu.org/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2"
  mirror "ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.1/gcc-4.9.1.tar.bz2"
  sha1 "3f303f403053f0ce79530dae832811ecef91197e"

  depends_on "gcc"
  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "cf-binutils"

  keg_only "This formula is currently being tested."

  if MacOS.version < :mavericks
    onoe "This formula is tested Only on OS X Mavericks."
  end

  fails_with :llvm do
    build 2334
    cause "This formula is intended to be built with GCC."
  end

  fails_with :clang do
    build 503
    cause "This formula is intended to be built with GCC."
  end

  def install
    # GCC can't find the cross-binutils, because it uses the cf- prefix.
    # We need to point GCC at those tools explicitly.
    # 
    binutils = Formula["cf-binutils"].opt_prefix
    ENV["AR_FOR_TARGET"]      = "#{binutils}/bin/cf-ar"
    ENV["AS_FOR_TARGET"]      = "#{binutils}/bin/cf-as"
    ENV["LD_FOR_TARGET"]      = "#{binutils}/bin/cf-ld"
    ENV["NM_FOR_TARGET"]      = "#{binutils}/bin/cf-nm"
    ENV["OBJCOPY_FOR_TARGET"] = "#{binutils}/bin/cf-objcopy"
    ENV["OBJDUMP_FOR_TARGET"] = "#{binutils}/bin/cf-objdump"
    ENV["RANLIB_FOR_TARGET"]  = "#{binutils}/bin/cf-ranlib"
    ENV["READELF_FOR_TARGET"] = "#{binutils}/bin/cf-readelf"
    ENV["STRIP_FOR_TARGET"]   = "#{binutils}/bin/cf-strip"

    mkdir "build" do
      args = [
          "--disable-debug",
          "--disable-dependency-tracking",
          "--prefix=#{prefix}",
          "--with-local-prefix=#{prefix}",
          "--program-prefix=cf-",
          "--target=m68k-none-elf",
          "--with-cpu=5307",
          "--enable-languages=c",
          # "--without-headers",
          # "--enable-version-specific-runtime-libs",
          "--with-gmp=#{Formula["gmp"].opt_prefix}",
          "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
          "--with-mpc=#{Formula["libmpc"].opt_prefix}",
          # "--with-cloog=#{Formula["cloog"].opt_prefix}",
          # "--with-isl=#{Formula["isl"].opt_prefix}",
          "--disable-libgomp",
          "--disable-libssp",
          "--disable-libquadmath",
          "--disable-libvtv",
          "--disable-shared",
          "--disable-threads",
          "--disable-tls",
          "--disable-nls",
          "--disable-werror"
      ]
      system "../configure", *args
      system "make"
      system "make install"
      # system "make", "all-gcc", "all-target-libgcc"
      # system "make", "install-gcc", "install-target-libgcc"
    end

    # Remove files that conflict with Homebrew gcc
    rm_rf share/info
  end
end
