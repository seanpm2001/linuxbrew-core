class Butane < Formula
  desc "Translates human-readable Butane Configs into machine-readable Ignition Configs"
  homepage "https://github.com/coreos/butane"
  url "https://github.com/coreos/butane/archive/v0.13.1.tar.gz"
  sha256 "b71a6cdb54fcacbf78adc06cc291958c228e5a9c8de3cacf04cebc0925ae37ab"
  license "Apache-2.0"
  head "https://github.com/coreos/butane.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "13affa67662c5dd527e86d01c9000eb6457c97045be5b50f8aad9e0fb2772406"
    sha256 cellar: :any_skip_relocation, big_sur:       "487ac17beeb2467b4303bf121f9d92990a2cea2e771054dc8c5a285703fcf16a"
    sha256 cellar: :any_skip_relocation, catalina:      "9f3bab80844e4d604d2af13099c5fcd89b94235b7e61ffb0cfbc3803c2028267"
    sha256 cellar: :any_skip_relocation, mojave:        "4004c1bc3911ab5bcdae308072fbd5cb96daee93c150810f84b27d954041c848"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18a7fe18d9358176615849685302c14aaeda4ca6a86845f714f6cbe5a269f8ac" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-mod=vendor",
      *std_go_args(ldflags: "-w -X github.com/coreos/butane/internal/version.Raw=#{version}"), "internal/main.go"
  end

  test do
    (testpath/"example.bu").write <<~EOS
      variant: fcos
      version: 1.3.0
      passwd:
        users:
          - name: core
            ssh_authorized_keys:
              - ssh-rsa mykey
    EOS

    (testpath/"broken.bu").write <<~EOS
      variant: fcos
      version: 1.3.0
      passwd:
        users:
          - name: core
            broken_authorized_keys:
              - ssh-rsa mykey
    EOS

    system "#{bin}/butane", "--strict", "--output=#{testpath}/example.ign", "#{testpath}/example.bu"
    assert_predicate testpath/"example.ign", :exist?
    assert_match(/.*"sshAuthorizedKeys":\["ssh-rsa mykey"\].*/m, File.read(testpath/"example.ign").strip)

    output = shell_output("#{bin}/butane --strict #{testpath}/example.bu")
    assert_match(/.*"sshAuthorizedKeys":\["ssh-rsa mykey"\].*/m, output.strip)

    shell_output("#{bin}/butane --strict --output=#{testpath}/broken.ign #{testpath}/broken.bu", 1)
    refute_predicate testpath/"broken.ign", :exist?

    assert_match version.to_s, shell_output("#{bin}/butane --version 2>&1")
  end
end
