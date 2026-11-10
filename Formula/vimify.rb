class Vimify < Formula
  desc "One vim-style keymap and theme for your CLI and TUI tools"
  homepage "https://github.com/ike-forge/vimify"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.2.1/vimify-aarch64-apple-darwin.tar.xz"
      sha256 "22eb80812a266ebb6b8847d52f152c5ec2162e8e3cc8684eefe5eb6be52f225f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.2.1/vimify-x86_64-apple-darwin.tar.xz"
      sha256 "b867032e89a93fcb21ec13b47fa5927da422c5a7589c27bd4abef4c77a8223da"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/vimify/releases/download/v0.2.1/vimify-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "443704602e1785ce299ba17191249bb580cf48a33df5c82fd0b79e9da8e14f5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/vimify/releases/download/v0.2.1/vimify-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba38dec99c9fbcdb70cc9e9b5ac64c0ccf713e9544562956b479312fb51acf90"
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
