class M68kCfGcc < Formula
  desc     "GCC cross-compiler to ColdFire targets"
  homepage "https://gcc.gnu.org"
  url      "https://ftp.gnu.org/gnu/gcc/gcc-7.1.0/gcc-7.1.0.tar.bz2"
  mirror   "https://ftpmirror.gnu.org/gcc/gcc-7.1.0/gcc-7.1.0.tar.bz2"
  sha256   "8a8136c235f64c6fef69cac0d73a46a1a09bb250776a050aec8f9fc880bebc17"

  # Dependencies
  depends_on "m68k-cf-binutils"
  depends_on "gmp"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "mpfr"

  # Needs to be built with GCC
  fails_with :clang

  def install
    # Get dependency locations
    gmp  = Formula["gmp"]    .opt_prefix
    isl  = Formula["isl"]    .opt_prefix
    mpc  = Formula["libmpc"] .opt_prefix
    mpfr = Formula["mpfr"]   .opt_prefix

    binutils = "#{Formula["m68k-cf-binutils"].opt_prefix}/bin/m68k-cf-elf"

    # Set target binary locations
    ENV["AR_FOR_TARGET"]      = "#{binutils}-ar"
    ENV["AS_FOR_TARGET"]      = "#{binutils}-as"
    ENV["LD_FOR_TARGET"]      = "#{binutils}-ld"
    ENV["NM_FOR_TARGET"]      = "#{binutils}-nm"
    ENV["OBJCOPY_FOR_TARGET"] = "#{binutils}-objcopy"
    ENV["OBJDUMP_FOR_TARGET"] = "#{binutils}-objdump"
    ENV["RANLIB_FOR_TARGET"]  = "#{binutils}-ranlib"
    ENV["READELF_FOR_TARGET"] = "#{binutils}-readelf"
    ENV["STRIP_FOR_TARGET"]   = "#{binutils}-strip"

    # Set configure arguments
    args = [
      # More info:
      # https://gcc.gnu.org/install/configure.html
      # ./configure --help=recursive | less

      # Target
      "--target=m68k-cf-elf",
      "--with-arch=cf",
      "--with-cpu=5307",
      "--disable-lto",

      # C compiler only
      "--enable-languages=c",

      # Isolation
      "--prefix=#{prefix}",
      "--with-local-prefix=#{prefix}",

      # Dependencies
      "--with-as=#{binutils}-as",
      "--with-ld=#{binutils}-ld",
      "--with-gmp=#{gmp}",
      "--with-isl=#{isl}",
      "--with-mpfr=#{mpfr}",
      "--with-mpc=#{mpc}",

      # Do not use any target headers from a libc
      "--without-headers",

      # Do not build libraries not useful for this target
      "--disable-libgomp",
      "--disable-libquadmath",
      "--disable-libsanitizer",
      "--disable-libssp",
      "--disable-libvtv",

      # Build static libraries only
      "--disable-shared",

      # Output diagnostics in American English only
      "--disable-nls",

      # Speeds up one-time builds
      "--disable-dependency-tracking",
    ]

    # Build
    mkdir "build" do
      system "../configure", *args
      system "make"
      system "make", "install"
    end

    # Remove files that conflict with Homebrew gcc
    rm_rf info
    rm_rf man7
  end

  test do
    # Just using this formula for cpp, so no real need for much here
    system bin/"m68k-cf-elf-gcc", "--help"
  end
end
