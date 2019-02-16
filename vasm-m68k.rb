class VasmM68k < Formula
  desc     "Portable and retargetable assembler (68K/CPU32/ColdFire back-end)"
  homepage "http://sun.hasenbraten.de/vasm/"
  url      "http://server.owl.de/~frank/tags/vasm1_8e.tar.gz"
  version  "1.8e"
  sha256   "5f1ebb8b81d2d9664e5c2646f1abbc5fb795642ed117f55e84a66590a62760ff"
  head     "http://sun.hasenbraten.de/vasm/daily/vasm.tar.gz"

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
