require 'formula'

class Mcf5307Binutils < Formula
  homepage 'http://www.gnu.org/software/binutils/binutils.html'
  url 'http://ftpmirror.gnu.org/binutils/binutils-2.24.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz'
  sha1 '1b2bc33003f4997d38fadaa276c1f0321329ec56'

  def install
    system "./configure", "--program-prefix=mcf5307",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--enable-targets=m68k-elf",
                          "--with-arch=cf",
                          "--with-cpu=5307",
                          "--enable-multilib",
                          "--disable-werror"
    system "make"
    system "make check"
    system "make install"
  end
end
