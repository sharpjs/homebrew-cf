require "formula"

class VasmM68kMot < Formula
  desc "portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/"
  url "http://server.owl.de/~frank/tags/vasm1_7d.tar.gz"
  version "1.7d"
  sha256 "bb604d1ee65e28753aa8890ca99b4464eb7f74340e702bc9b2adf31a67cb860b"

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

