class Vimify < Formula
  desc "One vim-style keymap and theme for your CLI and TUI tools"
  homepage "https://github.com/ike-forge/vimify"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.3.0/vimify-aarch64-apple-darwin.tar.xz"
      sha256 "a3d713da437a60c2a9bd31b63d2b816f079961e069cc4e38eb533014a473c74f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.3.0/vimify-x86_64-apple-darwin.tar.xz"
      sha256 "63a0f72e75ad9dd934232c7fc031bd7aeeb618a5f011930d1dd15936f7cad1a0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.3.0/vimify-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "10bbcb3e6dd7ceb864ff4fa1928cfe995d71e11eb1aad4634656ec217650110e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.3.0/vimify-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d13958c6aa296f1fe70c60e33eae61a951b3aedf16bf0f4521ba3c1abf4339e"
    end
  end

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
      bin.install "vimify"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vimify"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vimify"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vimify"
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
