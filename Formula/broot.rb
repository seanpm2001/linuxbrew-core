class Broot < Formula
  desc "New way to see and navigate directory trees"
  homepage "https://dystroy.org/broot"
  url "https://github.com/Canop/broot/archive/v0.18.1.tar.gz"
  sha256 "8ce229474bc59902cbe09d4cfa2a9bc4b3c4293a73fa51b37032927083636cd4"
  head "https://github.com/Canop/broot.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "645a6cda907866498982643a9b0401fac7e065d419d99309d342faaf1ff8b253" => :catalina
    sha256 "61070756e957e6460d94bef42e311af880f59c734a2e9e094817edb0c618ff0b" => :mojave
    sha256 "df153f03142e17895013426d2c51c928fffd5a6e9e58e1b26f5c34ccfd6f0c44" => :high_sierra
    sha256 "5b0bf5a28c5139c7b4b80466e161100a63e6527c90df82b598acc1c117659e5c" => :x86_64_linux
  end

  depends_on "rust" => :build

  uses_from_macos "zlib"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "A tree explorer and a customizable launcher", shell_output("#{bin}/broot --help 2>&1")

    return if !OS.mac? && ENV["CI"]

    require "pty"
    require "io/console"
    PTY.spawn(bin/"broot", "--cmd", ":pt", "--no-style", "--out", testpath/"output.txt", :err => :out) do |r, w, pid|
      r.winsize = [20, 80] # broot dependency termimad requires width > 2
      w.write "n\r"
      assert_match "New Configuration file written in", r.read
      Process.wait(pid)
    end
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
