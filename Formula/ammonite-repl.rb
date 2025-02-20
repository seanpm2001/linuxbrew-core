class AmmoniteRepl < Formula
  desc "Ammonite is a cleanroom re-implementation of the Scala REPL"
  homepage "https://ammonite.io/"
  # Prefer 2.13-x.xx versions, until significant regression in 3.0-x.xx is resolved
  # See https://github.com/com-lihaoyi/Ammonite/issues/1190
  url "https://github.com/lihaoyi/Ammonite/releases/download/2.4.0/2.13-2.4.0"
  version "2.4.0"
  sha256 "d85df9aa1588ea135bf8487d6530f39eaa35d7ac8decc64819572168020cdfa0"
  license "MIT"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f9c796bc2a83e1ede7061445219ba512d64c488ed1537c4747ca3c84f0b5c87" # linuxbrew-core
  end

  depends_on "openjdk"

  def install
    (libexec/"bin").install Dir["*"].first => "amm"
    chmod 0755, libexec/"bin/amm"
    (bin/"amm").write_env_script libexec/"bin/amm", Language::Java.overridable_java_home_env
  end

  # This test demonstrates the bug on 3.0-x.xx versions
  # If/when it passes there, it should be safe to upgrade again
  test do
    (testpath/"testscript.sc").write <<~EOS
      #!/usr/bin/env amm
      @main
      def fn(): Unit = println("hello world!")
    EOS
    output = shell_output("#{bin}/amm #{testpath}/testscript.sc")
    assert_equal "hello world!", output.lines.last.chomp
  end
end
