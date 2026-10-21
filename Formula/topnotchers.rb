class Topnotchers < Formula
  desc "Minimal notch monitor for Claude Code and Codex"
  homepage "https://github.com/joey-david/topnotchers"
  url "https://github.com/joey-david/topnotchers/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "280c231c708968581ba6978908ffcd397ef3c49903c4a6ae359618115bc03939"
  license "Apache-2.0"

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
