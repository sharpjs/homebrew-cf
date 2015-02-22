require 'formula'

class M68kCfBinutils < Formula
  homepage "http://www.gnu.org/software/binutils/binutils.html"
  url "http://ftpmirror.gnu.org/binutils/binutils-2.25.tar.gz"
  mirror "http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz"
  sha1 "f10c64e92d9c72ee428df3feaf349c4ecb2493bd"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--oldincludedir=#{prefix}/include",
                          "--target=m68k-cf-elf",
                          "--disable-nls",
                          "--disable-werror"
    system "make"
    system "make check"
    system "make install"

    # Remove files that conflict with Homebrew binutils
    rm_rf share/info
  end
end

