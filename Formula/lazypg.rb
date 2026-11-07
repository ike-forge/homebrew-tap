class Lazypg < Formula
  desc "A terminal UI for PostgreSQL"
  homepage "https://github.com/ike-forge/lazypg"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazypg/releases/download/v0.2.1/lp-app-aarch64-apple-darwin.tar.xz"
      sha256 "b74f818ae8694e78f01989b39c11a5fe70baf24c55d6d1b3bcf4212fedbec1de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazypg/releases/download/v0.2.1/lp-app-x86_64-apple-darwin.tar.xz"
      sha256 "a6c33aa3673fca587468a0d874fdecfd879670d1309fd5b17d8513d213e86453"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazypg/releases/download/v0.2.1/lp-app-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9393529e8768bac851d48cb511ad1a89616aa248943178755ed6fbf0effdcbef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazypg/releases/download/v0.2.1/lp-app-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a1b46cd940ea5501f901fa2e1387d236f837b1dec8134bb8e958493584b1b0fe"
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
      bin.install "lazypg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lazypg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lazypg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lazypg"
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
