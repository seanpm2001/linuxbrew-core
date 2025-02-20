class ProtocGenGogofaster < Formula
  desc "Protocol Buffers for Go with Gadgets"
  homepage "https://github.com/gogo/protobuf"
  url "https://github.com/gogo/protobuf/archive/v1.3.2.tar.gz"
  sha256 "2bb4b13d6e56b3911f09b8e9ddd15708477fbff8823c057cc79dd99c9a452b34"
  license "BSD-3-Clause"
  revision 2
  head "https://github.com/gogo/protobuf.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "55f33ac4a991f8e935b7d86d9fbe73f0df950548844a2cead274b02376483990"
    sha256 cellar: :any_skip_relocation, big_sur:       "6fba8cafcb5492731cf7ef4916cd4dcf60863f51db329b13dd9549a1082f196b"
    sha256 cellar: :any_skip_relocation, catalina:      "6fba8cafcb5492731cf7ef4916cd4dcf60863f51db329b13dd9549a1082f196b"
    sha256 cellar: :any_skip_relocation, mojave:        "6fba8cafcb5492731cf7ef4916cd4dcf60863f51db329b13dd9549a1082f196b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86c6120204262486b4d8fc189b65bf27654e7ca76b3a56c62aa535ff008f1076" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "protobuf"

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w", "./protoc-gen-gogofaster"
  end

  test do
    protofile = testpath/"proto3.proto"
    protofile.write <<~EOS
      syntax = "proto3";
      package proto3;
      message Request {
        string name = 1;
        repeated int64 key = 2;
      }
    EOS
    system "protoc", "--gogofaster_out=.", "proto3.proto"
    assert_predicate testpath/"proto3.pb.go", :exist?
    refute_predicate (testpath/"proto3.pb.go").size, :zero?
  end
end
