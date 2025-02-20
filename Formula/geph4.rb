class Geph4 < Formula
  desc "Modular Internet censorship circumvention system to deal with national filtering"
  homepage "https://geph.io/"
  url "https://github.com/geph-official/geph4/archive/v4.4.20.tar.gz"
  sha256 "90b778edc01dd3de6bee073b22b5c2151c326b6fdf921fbf7d7af6633ea1f75a"
  license "GPL-3.0-only"
  head "https://github.com/geph-official/geph4.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ccb2f2f58553241167e16ac1a537573a155255a1f529dda55163f5df88eaea08"
    sha256 cellar: :any_skip_relocation, big_sur:       "d78aa96fe152ffbaf59b262fe6ed5fdc78bc71215fc55b3e5893b82e100865f3"
    sha256 cellar: :any_skip_relocation, catalina:      "0d158c47acaa8221ee4db67333eca2d06a9cf6ea58e8dd1a72be463705951713"
    sha256 cellar: :any_skip_relocation, mojave:        "d5de96622d23bc8c574bd662941a415d85a8f0d71823b4014c1074a7606e7d80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e536f9bd27d003f6fda93d107a498e258fd26666ee03497cf0edfccdeeee8f2d" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    (buildpath/".cargo").rmtree
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "{\"error\":\"wrong password\"}",
     shell_output("#{bin}/geph4-client sync --username 'test' --password 'test' --credential-cache ~/test.db")
       .lines.last.strip
  end
end
