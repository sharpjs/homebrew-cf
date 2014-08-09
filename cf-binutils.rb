require 'formula'

class CfBinutils < Formula
  homepage 'http://www.gnu.org/software/binutils/binutils.html'
  url 'http://ftpmirror.gnu.org/binutils/binutils-2.24.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz'
  sha1 '1b2bc33003f4997d38fadaa276c1f0321329ec56'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--oldincludedir=#{prefix}/include",
                          "--program-prefix=cf-",
                          "--target=m68k-none-elf",
                          "--disable-nls",
                          "--disable-werror"
    system "make"
    system "make check"
    system "make install"

    # Remove files that conflict with Homebrew binutils
    rm_rf share/info
  end
end
