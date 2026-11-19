class Wingmux < Formula
  desc "Tmux-native control centre for supervising coding agents across repositories and worktrees"
  homepage "https://github.com/ike-forge/wingmux"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.3.0/wingmux-aarch64-apple-darwin.tar.xz"
      sha256 "bb761efad6c4169de0916d5d9afd38c9b5961a42f17fed54cf186a5e54cf711c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.3.0/wingmux-x86_64-apple-darwin.tar.xz"
      sha256 "1dccbd34919c5af51cfa24e35ec0c9a9530656de7fddb816c0cf301fb234c775"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.3.0/wingmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "643c3792e07048365ba13afa60f0914ba0acd4f31359d49dfafe71c48bf190d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.3.0/wingmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f506a958c6b94c062055b0530dcef690f9075b21e65061cfd479788a765c4cf5"
    end
  end
  license "0BSD"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "wing", "wingmux"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "wing", "wingmux"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "wing", "wingmux"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "wing", "wingmux"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
