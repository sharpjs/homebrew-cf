class M68kCfBinutils < Formula
  desc     "GNU binutils for ColdFire targets"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url      "https://ftp.gnu.org/gnu/binutils/binutils-2.29.1.tar.bz2"
  mirror   "https://ftpmirror.gnu.org/binutils/binutils-2.29.1.tar.bz2"
  sha256   "1509dff41369fb70aed23682351b663b56db894034773e6dbf7d5d6071fc55cc"

  def install
    args = [
      # Target
      "--target=m68k-cf-elf",

      # Isolation
      "--prefix=#{prefix}",
      "--oldincludedir=#{include}",

      # Output diagnostics in American English only
      "--disable-nls",

      # Still used?
      "--disable-debug",

      # Do not stop for warnings
      "--disable-werror",

      # Speeds up one-time builds
      "--disable-dependency-tracking",
    ]

    # Build and install
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"

    # Remove files that conflict with Homebrew binutils
    rm_rf info
  end

  test do
    (testpath/"test.s").write "move.l %d0, %d1\n"
    system bin/"m68k-cf-elf-as", "-o", "/dev/null", "test.s"
  end
end
