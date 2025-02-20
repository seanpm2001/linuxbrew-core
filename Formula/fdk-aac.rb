class FdkAac < Formula
  desc "Standalone library of the Fraunhofer FDK AAC code from Android"
  homepage "https://sourceforge.net/projects/opencore-amr/"
  url "https://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.2.tar.gz"
  sha256 "c9e8630cf9d433f3cead74906a1520d2223f89bcd3fa9254861017440b8eb22f"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "cf0840a736c0cd0f009e7b3015545ac46fc6c5474163c4f04514065b6cc16454"
    sha256 cellar: :any,                 big_sur:       "21df35d8501a3962ae713c598b4c94300938cabe8bded66021d0aff129fe00ef"
    sha256 cellar: :any,                 catalina:      "b4e0f2728235e4763c6a4d95b0c4eafdb28119e5f4f22397e23e35dacb88e8a8"
    sha256 cellar: :any,                 mojave:        "76e2a579c432470211d10a58284267edce7eae47ccfea7ed334426b9594d309a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3dfa22dedca4182aed74b7e74bf5908572c5e5fe0c11b9a75de1f0e37122752d" # linuxbrew-core
  end

  head do
    url "https://git.code.sf.net/p/opencore-amr/fdk-aac.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-example"
    system "make", "install"
  end

  test do
    system "#{bin}/aac-enc", test_fixtures("test.wav"), "test.aac"
    assert_predicate testpath/"test.aac", :exist?
  end
end
