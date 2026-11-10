class Wingmux < Formula
  desc "Tmux-native control centre for supervising coding agents across repositories and worktrees"
  homepage "https://github.com/ike-forge/wingmux"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.6/wingmux-aarch64-apple-darwin.tar.xz"
      sha256 "09c8d7cee20eb442ce607dd371a1dc969af85c19e084d95ee10f7915e4c58b96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.6/wingmux-x86_64-apple-darwin.tar.xz"
      sha256 "128b0ad6107e01b69c7c4bc46d902970a1afb91318dfce592f6450bf5679f253"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.6/wingmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1869a9dd7596044030a9b6e327ece64358a5efeebbafa89abb8d75dbd07cf913"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.6/wingmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9ece49a78b67a474d818011a99e33d6362df5171e6f6c549fb456160aa2e3913"
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
