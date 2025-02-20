class TtyClock < Formula
  desc "Digital clock in ncurses"
  homepage "https://github.com/xorg62/tty-clock"
  url "https://github.com/xorg62/tty-clock/archive/v2.3.tar.gz"
  sha256 "343e119858db7d5622a545e15a3bbfde65c107440700b62f9df0926db8f57984"
  license "BSD-3-Clause"
  head "https://github.com/xorg62/tty-clock.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fcae9d0e0eeaf68815b4a521f7f75c352d4188a38652b4841bd48b608120edce"
    sha256 cellar: :any_skip_relocation, big_sur:       "fd72f43c25837763c243876436de51d99369fb8f540171aec16b2f66cb2870e3"
    sha256 cellar: :any_skip_relocation, catalina:      "dc5a60415f5cd5397d973b361db6bc0db2172621fe6eed037ee05c851097c27d"
    sha256 cellar: :any_skip_relocation, mojave:        "eab206747869e0190d82dfa71d7763df4a3f202c3035f7bccb5b32fc52580989"
    sha256 cellar: :any_skip_relocation, high_sierra:   "b3d2a19cdb38e0e156be552d6f9ca8926097300f17bbe6628b7443934d3e1cb1"
    sha256 cellar: :any_skip_relocation, sierra:        "9b0e056ec6d86d9ba9cbd2abc02236607a6ad5601e7a656d10cad20182564315"
    sha256 cellar: :any_skip_relocation, el_capitan:    "c0d981769811bf1c265e11702ea0d26bcf87102ac92896c04c14a91fbed1cc8c"
    sha256 cellar: :any_skip_relocation, yosemite:      "9341fb07070b665dc5f9593c1b4811ec734f7221afbde2547cee55fc9102aa1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ccb3a60434af5ef907f315dda369cbf8aacd919e9fea2aa2df375c289968d04" # linuxbrew-core
  end

  depends_on "pkg-config" => :build

  uses_from_macos "ncurses"

  def install
    ENV.append "LDFLAGS", "-lncurses"
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/tty-clock", "-i"
  end
end
