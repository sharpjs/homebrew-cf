require "formula"

class VasmM68kMot < Formula
  desc "portable and retargetable assembler"
  homepage "http://sun.hasenbraten.de/vasm/"
  url "http://server.owl.de/~frank/tags/vasm1_7d.tar.gz"
  version "1.7d"
  sha256 "bb604d1ee65e28753aa8890ca99b4464eb7f74340e702bc9b2adf31a67cb860b"

  def install
    inreplace "Makefile" do |s|
      s.change_make_var! "COPTS", "-c #{ENV.cflags}"
      s.change_make_var! "LDFLAGS", "-lm #{ENV.ldflags}"
    end

    cpu    = "m68k"
    syntax = "mot"
    vasm   = "vasm#{cpu}_#{syntax}"

    system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}", vasm
    system "make", "vobjdump"

    bin.install vasm
    bin.install "vobjdump"
  end
end

