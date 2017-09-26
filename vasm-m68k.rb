class VasmM68k < Formula
  desc     "Portable and retargetable assembler (68K/CPU32/ColdFire back-end only)"
  homepage "http://sun.hasenbraten.de/vasm/"
  url      "http://server.owl.de/~frank/tags/vasm1_8a.tar.gz"
  sha256   "69981927a5e12f4befeb4b4b7b5eec8114f1470f7ec9131f9adf11034ab75c9f"

  option "without-std",   "Disable MIT (GNU as-style) syntax"
  option "without-mot",   "Disable Motorola/Freescale/Devpac 68K syntax"
  option "with-madmac",   "Enable Atari MadMac syntax"
  option "with-oldstyle", "Enable old 8-bit-style syntax"

  VASM_CPU = :m68k

  def install
    make_vasm "std"      if build.with? "std"
    make_vasm "mot"      if build.with? "mot"
    make_vasm "madmac"   if build.with? "madmac"
    make_vasm "oldstyle" if build.with? "oldstyle"

    install_vasm "std"      if build.with? "std"
    install_vasm "mot"      if build.with? "mot"
    install_vasm "madmac"   if build.with? "madmac"
    install_vasm "oldstyle" if build.with? "oldstyle"
  end

  test do
    (testpath/"test.s").write " move.l d0,d1\n"

    test_vasm "std"      if build.with? "std"
    test_vasm "mot"      if build.with? "mot"
    test_vasm "madmac"   if build.with? "madmac"
    test_vasm "oldstyle" if build.with? "oldstyle"
  end

  def make_vasm(syntax)
    system "make", "CPU=#{VASM_CPU}", "SYNTAX=#{syntax}"
  end

  def install_vasm(syntax)
    bin.install "vasm#{VASM_CPU}_#{syntax}"
  end

  def test_vasm(syntax)
    system bin/"vasm#{VASM_CPU}_#{syntax}", "-Ftest", "test.s"
  end
end
