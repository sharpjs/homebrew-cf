require "formula"

class VasmM68kMot < Formula
  desc "Portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/"
  url "http://server.owl.de/~frank/tags/vasm1_7e.tar.gz"
  version "1.7e"
  sha256 "2878c9c62bd7b33379111a66649f6de7f9267568946c097ffb7c08f0acd0df92"

  def install
    cpu    = "m68k"
    syntax = "mot"

    system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}"

    bin.install "vasm#{cpu}_#{syntax}"
    bin.install "vobjdump"
  end

  test do
    (testpath/"test.s").write " move.l d0,d1\n"
    system bin/"vasmm68k_mot", "-Felf", "test.s"
  end
end

