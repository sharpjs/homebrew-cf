require 'formula'

class M68kCfBinutils < Formula
  homepage "http://www.gnu.org/software/binutils/binutils.html"
  url      "http://ftpmirror.gnu.org/binutils/binutils-2.26.tar.bz2"
  mirror   "http://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.bz2"
  sha256   "c2ace41809542f5237afc7e3b8f32bb92bc7bc53c6232a84463c423b0714ecd9"

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

