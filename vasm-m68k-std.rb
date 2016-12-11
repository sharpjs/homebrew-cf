require "formula"

class VasmM68kStd < Formula
  desc     "Portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/"
  url      "http://server.owl.de/~frank/tags/vasm1_7g.tar.gz"
  version  "1.7g_1"
  sha256   "9cfca33c348fe10419cb2ef59a7ff25c262cd6cf1d353bb51d4468f1f1535c55"

  def install
    cpu    = "m68k"
    syntax = "std"

    system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}"

    bin.install "vasm#{cpu}_#{syntax}"
    #bin.install "vobjdump" # if needed, make a separate formula
  end

  test do
    (testpath/"test.s").write " move.l d0,d1\n"
    system bin/"vasmm68k_std", "-Felf", "test.s"
  end
end
