require 'formula'

class M68kCfGcc < Formula
  homepage "http://gcc.gnu.org"
  url "http://ftpmirror.gnu.org/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2"
  mirror "ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.1/gcc-4.9.1.tar.bz2"
  sha1 "3f303f403053f0ce79530dae832811ecef91197e"

  depends_on "gcc"
  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "m68k-cf-binutils"

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
    mkdir "build" do
      args = [
          "--disable-debug",
          "--disable-dependency-tracking",
          "--prefix=#{prefix}",
          "--with-local-prefix=#{prefix}",
          "--target=m68k-cf-elf",
          "--with-arch=cf",
          "--with-cpu=5307",
          "--enable-languages=c",
          "--without-headers",
          "--with-gmp=#{Formula["gmp"].opt_prefix}",
          "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
          "--with-mpc=#{Formula["libmpc"].opt_prefix}",
          "--disable-lto",
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
      system "make", "install"
    end

    # Remove files that conflict with Homebrew gcc
    rm_rf share/info
    rm_rf share/man/man7
  end
end

