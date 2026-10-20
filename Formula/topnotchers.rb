class Topnotchers < Formula
  desc "Your coding agents, living in your Mac's notch"
  homepage "https://github.com/joey-david/topnotchers"
  url "https://github.com/joey-david/topnotchers/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b8f7492ed718e8c2b3722d6ae8c07045e20ad6584494ef70462aecd604e2a370"
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
