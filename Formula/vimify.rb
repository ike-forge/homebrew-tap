class Vimify < Formula
  desc "One vim-style keymap and theme for your CLI and TUI tools"
  homepage "https://github.com/ike-forge/vimify"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.5.0/vimify-aarch64-apple-darwin.tar.xz"
      sha256 "d6d155c1e3f5fe1d4b4504f176538458ef0cc035a73c57c6b0af96e4b8a4c84e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.5.0/vimify-x86_64-apple-darwin.tar.xz"
      sha256 "372fac20bbad40ed92c360d6cfe415eddba89cfa37cd6a7915c5fbbd6b8a8ad5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.5.0/vimify-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e70b0626753b99a3ac52442b3bea0e0c137f366dc2962654bb0ddd3316b2eadf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.5.0/vimify-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff25f69662b766fa856432f67f9e35412cd0dd1b52acc943aa2270bd8ee22206"
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
