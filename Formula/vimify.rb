class Vimify < Formula
  desc "One vim-style keymap and theme for your CLI and TUI tools"
  homepage "https://github.com/ike-forge/vimify"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.4.0/vimify-aarch64-apple-darwin.tar.xz"
      sha256 "fdab06a9b6295d3a89111a053b3763ace84223e3577f5dfb983ea27eacee12f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.4.0/vimify-x86_64-apple-darwin.tar.xz"
      sha256 "4663690a9d3a7877b0e052755417f2f3fd379813fcc99705dbe41dac40707364"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.4.0/vimify-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5ca44278d184168c1be3ad9e3b33cecd4e58140e240e0a7bd7fa8f3e923e99ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.4.0/vimify-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e51ae22114306397f613e721563ddd034855394f82da9829617ba5eb2b0dcfd2"
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
