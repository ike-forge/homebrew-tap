class Lazydb < Formula
  desc "A terminal UI for PostgreSQL and Cassandra"
  homepage "https://github.com/ike-forge/lazydb"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.1.0/ld-app-aarch64-apple-darwin.tar.xz"
      sha256 "8d670e638d0cd52b8ce119613b2ef6ccb1f06d5990af7ba5d567bc9088bdf146"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.1.0/ld-app-x86_64-apple-darwin.tar.xz"
      sha256 "ddfd39c24263982b6d8b05b7c8642cf1faeabc311c951196b79b8d2e2a06d15d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.1.0/ld-app-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b29210f7fc86325cecc3a09a8f21171ba71d7ecdbf65501dd02146dea2fd6a95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.1.0/ld-app-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3c12481d0390645ea774ec8592e34e92e7364309e12ced88d3705da8f2f6068"
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
