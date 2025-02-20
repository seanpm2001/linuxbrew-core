class Calceph < Formula
  desc "C library to access the binary planetary ephemeris files"
  homepage "https://www.imcce.fr/inpop/calceph"
  url "https://www.imcce.fr/content/medias/recherche/equipes/asd/calceph/calceph-3.5.0.tar.gz"
  sha256 "2aa9ba47af6a73ab74ae10d1c8efbcfab9068d9d05f016a8a5fe695df7b52e00"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?calceph[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "9c3abdc353fa28b0f073f59579866f5f4ebe1394af3f48cceff39664077f2d67"
    sha256 cellar: :any,                 big_sur:       "09f5d187d213d349fe8f0035cc26a08f8cee34e43efa691f1bd882df968540b2"
    sha256 cellar: :any,                 catalina:      "36e5388c8789221831f181d7e9ec7d2ad822e4f76afca20533912508ca38913c"
    sha256 cellar: :any,                 mojave:        "22799e0c12c14a7a50062e5d0c482460d1fd8317a32fbf8063aca797d7e83bc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6684443f24392f477d629d6d3da6a067d1bf73892dd465e6bd8421037118c54" # linuxbrew-core
  end

  depends_on "gcc" # for gfortran

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"testcalceph.c").write <<~EOS
      #include <calceph.h>
      #include <assert.h>

      int errorfound;
      static void myhandler (const char *msg) {
        errorfound = 1;
      }

      int main (void) {
        errorfound = 0;
        calceph_seterrorhandler (3, myhandler);
        calceph_open ("example1.dat");
        assert (errorfound==1);
        return 0;
      }
    EOS
    system ENV.cc, "testcalceph.c", "-L#{lib}", "-lcalceph", "-o", "testcalceph"
    system "./testcalceph"
  end
end
