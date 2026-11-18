class Lazydb < Formula
  desc "A terminal UI for PostgreSQL and Cassandra"
  homepage "https://github.com/ike-forge/lazydb"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.2.0/ld-app-aarch64-apple-darwin.tar.xz"
      sha256 "cd104f5892078fd27afc38fd83b7f4da3a96fc249ab31e6edb931b32b2693e41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.2.0/ld-app-x86_64-apple-darwin.tar.xz"
      sha256 "88c3d197f5a87deec2e7c80d3ef4c3632a6a70a7f926cfe06ca4e29eb99fbe2c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.2.0/ld-app-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8c78a08859018c4062f2a4be3a0ad1dee9fab77655c107c2c1aa7c923e38e06e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.2.0/ld-app-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a29e05b74c8ba61c294a82c1747884b85fcf1cac01a972ee227a0fea9c411efe"
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
      bin.install "lazydb"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lazydb"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lazydb"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lazydb"
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
