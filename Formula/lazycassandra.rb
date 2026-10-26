class Lazycassandra < Formula
  desc "A terminal UI for Apache Cassandra"
  homepage "https://github.com/ike-forge/lazycassandra"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.2/lc-app-aarch64-apple-darwin.tar.xz"
      sha256 "442fc4d7780e095f04f9874d28210f59555e0948474ef14496b5fddc5f178664"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.2/lc-app-x86_64-apple-darwin.tar.xz"
      sha256 "26f9bc1ba90934082b03743e67863fcf4451a917bd8ab656f9d402ff7c484038"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.2/lc-app-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5263cbe6ec1d226b29fbaec0c635730362804f30a071badb306b23bf0765a31a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.2/lc-app-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "86f65b1368c904b77c1d205f8c7d3acaceb046ae28ef14d62f07ee6a09b17388"
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
      bin.install "lazycassandra"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lazycassandra"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lazycassandra"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lazycassandra"
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
