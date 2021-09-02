class Gojq < Formula
  desc "Pure Go implementation of jq"
  homepage "https://github.com/itchyny/gojq"
  url "https://github.com/itchyny/gojq.git",
      tag:      "v0.12.5",
      revision: "727b4b58cf84985ffdc61cf81677b37d757d7151"
  license "MIT"
  head "https://github.com/itchyny/gojq.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3d5070f13196e75857508da8cc98f179c1b35f95e0d49159833b48ed0281810c"
    sha256 cellar: :any_skip_relocation, big_sur:       "1d41987fde95d422eaa3cb4401e3b608b9f1f2ff4dcf7b93326cac71f1b67a89"
    sha256 cellar: :any_skip_relocation, catalina:      "1d41987fde95d422eaa3cb4401e3b608b9f1f2ff4dcf7b93326cac71f1b67a89"
    sha256 cellar: :any_skip_relocation, mojave:        "1d41987fde95d422eaa3cb4401e3b608b9f1f2ff4dcf7b93326cac71f1b67a89"
  end

  depends_on "go" => :build

  def install
    revision = Utils.git_short_head
    ldflags = %W[
      -s -w
      -X github.com/itchyny/gojq/cli.revision=#{revision}
    ]
    system "go", "build", "-ldflags", ldflags.join(" "), *std_go_args, "./cmd/gojq"
    zsh_completion.install "_gojq"
  end

  test do
    assert_equal "2\n", pipe_output("#{bin}/gojq .bar", '{"foo":1, "bar":2}')
  end
end
