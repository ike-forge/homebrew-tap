class Lazydb < Formula
  desc "A terminal UI for PostgreSQL and Cassandra"
  homepage "https://github.com/ike-forge/lazydb"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.3.0/ld-app-aarch64-apple-darwin.tar.xz"
      sha256 "b5314f9e9f92be7e4b1d75c7a50af262d7f49a5d39aa86ed1a7c426d45102182"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.3.0/ld-app-x86_64-apple-darwin.tar.xz"
      sha256 "3b4b4fc1119162cf816c1f622ae6fdd1022c657b4d1149d6acaa9b784f8704d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.3.0/ld-app-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "57f48cd483b7ca27c62e9e95ed063d3236d1f2bc100a2d61fdbe20443544c8ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazydb/releases/download/v0.3.0/ld-app-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "892723baa745cf8f262b1f07065e9e36145fe0f81d4dd416ffc24921753825c4"
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
