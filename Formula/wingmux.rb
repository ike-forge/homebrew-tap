class Wingmux < Formula
  desc "Tmux-native control centre for supervising coding agents across repositories and worktrees"
  homepage "https://github.com/ike-forge/wingmux"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.5/wingmux-aarch64-apple-darwin.tar.xz"
      sha256 "cc613b6080a26f9d3401ed90de728039882e41e74c2f5883275c193aeee0e8ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.5/wingmux-x86_64-apple-darwin.tar.xz"
      sha256 "e7c6d7e70e4c43d55c484fbbada6cccead6b47177ff4f7c3031158d6f4914805"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.5/wingmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "412042649e96595bd7941ce9365460baa8b3a1de03fb1ade570300e1b73daefb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/wingmux/releases/download/v0.2.5/wingmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4ea0fd69574d1ae91991cbb74dafd4c6e63bbd2ba540f2c7602a7f15d8992a49"
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
