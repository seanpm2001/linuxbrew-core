class Dhcping < Formula
  desc "Perform a dhcp-request to check whether a dhcp-server is running"
  homepage "http://www.mavetju.org/unix/general.php"
  url "http://www.mavetju.org/download/dhcping-1.2.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/d/dhcping/dhcping_1.2.orig.tar.gz"
  sha256 "32ef86959b0bdce4b33d4b2b216eee7148f7de7037ced81b2116210bc7d3646a"

  livecheck do
    url :homepage
    regex(/href=.*?dhcping[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8126f3068682d4e4629158c4bec5f71fe557671ee93521d4a46286fcc8a9e53a"
    sha256 cellar: :any_skip_relocation, big_sur:       "cea21616fd5abd22da30648e6744ff16630f3ead891b8336ca668c3fa3f93a0a"
    sha256 cellar: :any_skip_relocation, catalina:      "6c8a4c00ebe101f4ad040238d79137025331d8af78327b77ef72d83da985402e"
    sha256 cellar: :any_skip_relocation, mojave:        "94dba411868455abd17d818d1009e71bae362cea093ec01437b19fbbb33a0cc2"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e30ef14d867a06bcc9bcde18965fa00366780c3323841ca0fb25f864077044d6"
    sha256 cellar: :any_skip_relocation, sierra:        "5c41d596cb2a9835fc5f170ccd602294c98f163ba3f2a8d5c83bae252189817e"
    sha256 cellar: :any_skip_relocation, el_capitan:    "d3b03b1004d3a2d97b80fbbe9714bd29d006d9099a8f6baec343feb2833f3996"
    sha256 cellar: :any_skip_relocation, yosemite:      "7741adb9bc166ee2450e521f7468e2b023632e737eb4da065848c5e87b6bd35a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e9caa0cf1255efac9ad5135ab1b0a7c82853f5f75877640b5d241bcd08e8f36" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end
end
