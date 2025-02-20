class Ohcount < Formula
  desc "Source code line counter"
  homepage "https://github.com/blackducksoftware/ohcount"
  url "https://github.com/blackducksoftware/ohcount/archive/4.0.0.tar.gz"
  sha256 "d71f69fd025f5bae58040988108f0d8d84f7204edda1247013cae555bfdae1b9"
  license "GPL-2.0"
  head "https://github.com/blackducksoftware/ohcount.git", branch: "master"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "43a0bac3974271a961f6cbb035aeb37e0f63e6fc05200bdf8b28064ca7faf128"
    sha256 cellar: :any, big_sur:       "4c6dbf352f569f3976b9c3992376f9afbd4cc05ceb1bbf129b4e462628dbe618"
    sha256 cellar: :any, catalina:      "49de65862c42d1e653b84aa09a3ca9015de5afa40d9c1069d5a7f5a4e35060e5"
    sha256 cellar: :any, mojave:        "b93054a4459a246895a524de21559fc1387e8cc6436d83481c7d85afc10be9e8"
    sha256 cellar: :any, high_sierra:   "2bcddb3687af78d9317be143579afe692f8a3034c51b1e7e07ddd53491792365"
    sha256 cellar: :any, sierra:        "716a64cf45acdb062651994384e88e74e5bf258a1b70b9b29cf09c5c115084e5"
    sha256 cellar: :any, x86_64_linux:  "91e2bfd24a6dc5025bf70842f73ecf1635663a380786a39f4e0f9749e3f42f31" # linuxbrew-core
  end

  depends_on "gperf" => :build
  depends_on "libmagic"
  depends_on "pcre"
  depends_on "ragel"

  def install
    system "./build", "ohcount"
    bin.install "bin/ohcount"
  end

  test do
    (testpath/"test.rb").write <<~EOS
      # comment
      puts
      puts
    EOS
    stats = shell_output("#{bin}/ohcount -i test.rb").lines.last
    assert_equal ["ruby", "2", "1", "33.3%"], stats.split[0..3]
  end
end
