class Topnotchers < Formula
  desc "Shows Claude Code and Codex sessions next to the notch"
  homepage "https://github.com/joey-david/topnotchers"
  url "https://github.com/joey-david/topnotchers/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "be4e51b287b1332f5ea81709a5557235aaeeebccb3775005513540a495f40261"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    system "./build.sh"
    libexec.install "build/Topnotchers.app", "build/topnotchers-hook", "install.sh", "tools"
    (bin/"topnotchers-setup").write <<~SH
      #!/bin/bash
      # Installs Topnotchers.app in ~/Applications and wires the Claude Code + Codex hooks.
      PREBUILT="#{libexec}" exec bash "#{libexec}/install.sh" "$@"
    SH
  end

  def caveats
    <<~EOS
      Run this once to put Topnotchers in ~/Applications and connect Claude Code and Codex:
        topnotchers-setup
      Run it again after `brew upgrade topnotchers`.
    EOS
  end

  test do
    assert_path_exists libexec/"Topnotchers.app/Contents/MacOS/Topnotchers"
    assert_path_exists libexec/"topnotchers-hook"
  end
end
