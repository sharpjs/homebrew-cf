require 'formula'

class M68kCfBinutils < Formula
  homepage "http://www.gnu.org/software/binutils/binutils.html"
  url      "http://ftpmirror.gnu.org/binutils/binutils-2.27.tar.bz2"
  mirror   "http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.bz2"
  sha256   "369737ce51587f92466041a97ab7d2358c6d9e1b6490b3940eb09fb0a9a6ac88"

  def install
    args = [
      # Target
      "--target=m68k-cf-elf",

      # Isolation
      "--prefix=#{prefix}",
      "--oldincludedir=#{prefix}/include",

      # Output diagnostics in American English only
      "--disable-nls",

      # Still used?
      "--disable-debug",

      # Do not stop for warnings
      "--disable-werror",

      # Speeds up one-time builds
      "--disable-dependency-tracking"
    ]

    # Build and install
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"

    # Remove files that conflict with Homebrew binutils
    rm_rf share/info
  end
end

