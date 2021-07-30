class Terragrunt < Formula
  desc "Thin wrapper for Terraform e.g. for locking state"
  homepage "https://terragrunt.gruntwork.io/"
  url "https://github.com/gruntwork-io/terragrunt/archive/v0.31.2.tar.gz"
  sha256 "8e64f411050b3cbed31a76519e9ecfb1d58f20ac829fef6357cc8e86a416b843"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "97a2c889f3383d515d2b3531433e539294abf5b728149aaf964ae22cad7c8515"
    sha256 cellar: :any_skip_relocation, big_sur:       "19f33aec3b54a405069b44cc45a632d8ed9998a71bd03de8ee538f27628cebd3"
    sha256 cellar: :any_skip_relocation, catalina:      "b7cded4af9f43d898da6d3b075b0623f877c96a02d8242c230c728901f847327"
    sha256 cellar: :any_skip_relocation, mojave:        "37554cb189ad496be42d7a8de784819d6935f9b06eddaee3bd0c8dc53e3ceaef"
  end

  depends_on "go" => :build
  depends_on "terraform"

  conflicts_with "tgenv", because: "tgenv symlinks terragrunt binaries"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.VERSION=v#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/terragrunt --version")
  end
end
