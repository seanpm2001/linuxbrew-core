class Gomplate < Formula
  desc "Command-line Golang template processor"
  homepage "https://gomplate.hairyhenderson.ca/"
  url "https://github.com/hairyhenderson/gomplate/archive/v3.10.0.tar.gz"
  sha256 "f9a30d8e94b81eefbbe3455c21dc547ec0ebf0e010a809c72db617a4b37223a6"
  license "MIT"
  head "https://github.com/hairyhenderson/gomplate.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "05845f4a31da3d5b78b61e119a62d7f9c869f471194de46d0b06b3b76b3cfc14"
    sha256 cellar: :any_skip_relocation, big_sur:       "92ce5929e369eb6a49e478f71bf2a6fba500094b600c578f4ba3ae0c0546dcc5"
    sha256 cellar: :any_skip_relocation, catalina:      "85ba008a9f271385b4599fe1308fa0846bde36307d96a39424c2aa53396ba12b"
    sha256 cellar: :any_skip_relocation, mojave:        "d08b4521c7140d8391be5aef5ab3cfa9184e080e5abf46dbea079025b49c4a0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ea36b582faae30e7df096ab4396f37e8c9a4d50db7b7f493532a8eb15eb0eaf" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "make", "build", "VERSION=#{version}"
    bin.install "bin/gomplate" => "gomplate"
    prefix.install_metafiles
  end

  test do
    output = shell_output("#{bin}/gomplate --version")
    assert_equal "gomplate version #{version}", output.chomp

    test_template = <<~EOS
      {{ range ("foo:bar:baz" | strings.SplitN ":" 2) }}{{.}}
      {{end}}
    EOS

    expected = <<~EOS
      foo
      bar:baz
    EOS

    assert_match expected, pipe_output("#{bin}/gomplate", test_template, 0)
  end
end
