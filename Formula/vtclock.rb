class Vtclock < Formula
  desc "Text-mode fullscreen digital clock"
  homepage "https://github.com/dse/vtclock"
  url "https://github.com/dse/vtclock/archive/0.0.20161228.tar.gz"
  sha256 "0148411febd672c34e436361f5969371ae5291bdc497c771af403a5ee85a78b4"
  license "GPL-2.0-or-later"
  version_scheme 1
  head "https://github.com/dse/vtclock.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7ba3ce880fdedf82e166ed0f7f7a4124c57510680d5c591fd363ac14887618f5"
    sha256 cellar: :any_skip_relocation, big_sur:       "747b98b591c6a732012006db26bc8cdd871509e6407f557a1b616c54d2c2079d"
    sha256 cellar: :any_skip_relocation, catalina:      "77d6846683ebe827ad322e81cd281e79d28b5e93122aadf32c49a1566b1c9f2e"
    sha256 cellar: :any_skip_relocation, mojave:        "1f4d80e05dcf1c214a317d54057674f496ff0a063d9acaedc3e845d212c627bd"
  end

  depends_on "pkg-config" => :build
  uses_from_macos "ncurses"

  def install
    system "make"
    bin.install "vtclock"
  end

  test do
    system "#{bin}/vtclock", "-h"
  end
end
