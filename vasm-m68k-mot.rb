require "formula"

class VasmM68kMot < Formula
  homepage "http://sun.hasenbraten.de/vasm/"
  url "http://sun.hasenbraten.de/vasm/release/vasm.tar.gz"
  version "1.7b"
  sha1 "40a25d82fcdf1f8e17f8103bb06075780b7866a2"

  def install
    inreplace "Makefile" do |s|
      s.change_make_var! "COPTS",   "-c #{ENV.cflags}"
      s.change_make_var! "LDFLAGS", "-lm #{ENV.ldflags}"
    end

    cpu = "m68k"
    syntax = "mot"

    system "make", "CPU=#{cpu}", "SYNTAX=#{syntax}", "vasm#{cpu}_#{syntax}"
    bin.install "vasm#{cpu}_#{syntax}"

    system "make", "vobjdump"
    bin.install "vobjdump"
  end
end

