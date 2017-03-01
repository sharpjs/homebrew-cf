require "formula"

class VasmM68kStd < Formula
  desc     "Portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/"
  url      "http://server.owl.de/~frank/tags/vasm1_7h.tar.gz"
  sha256   "5c012040cbfc2b16bdab0ad88dca31ec2f78b47b382c1048428ea1610063626d"
  version  "1.7h"
  #revision 1 # for formula updates between versions

  def install
    cpu    = "m68k"
    syntax = "std"

    system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}"

    bin.install "vasm#{cpu}_#{syntax}"
  end

  test do
    (testpath/"test.s").write " move.l d0,d1\n"
    system bin/"vasmm68k_std", "-Felf", "test.s"
  end
end

