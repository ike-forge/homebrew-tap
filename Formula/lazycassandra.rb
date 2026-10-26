class Lazycassandra < Formula
  desc "A terminal UI for Apache Cassandra"
  homepage "https://github.com/ike-forge/lazycassandra"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.1/lc-app-aarch64-apple-darwin.tar.xz"
      sha256 "54077992e5db564a30bd17cb8d6283811fb821043b30be2424da180c67448bbe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.1/lc-app-x86_64-apple-darwin.tar.xz"
      sha256 "b40480fba6e2eb014c08da2e2e069510a33bb91cb1ac6ca9e0a9431a7fe711d8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.1/lc-app-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2395829083a3fd9ad6c7bc4942c645b3ca9e59e92b7165c28529f196785a81d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ike-forge/lazycassandra/releases/download/v0.2.1/lc-app-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03ca4595c58ba0dad73df37a27bc18b67a6a5e6b1b7e3f43821ed51a9eab77dd"
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
