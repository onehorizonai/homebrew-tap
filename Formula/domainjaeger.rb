class Domainjaeger < Formula
  desc "Hunts for available domain names made of real words: cook.ing, sn.app, mike.ai"
  homepage "https://github.com/onehorizonai/domainjaeger"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.1/domainjaeger-aarch64-apple-darwin.tar.xz"
      sha256 "2b2743cfa636f53b601917c0987760c47e09558f154d1a081614bc189a727c67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.1/domainjaeger-x86_64-apple-darwin.tar.xz"
      sha256 "2004e17004c0b770877e6e7a8c95f85e460999380072c4d20b30ad7d883873fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.1/domainjaeger-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "10c26eeb881dbf026c3db6313e8a7d665cdcef2be7edb517a71228bb34d44d5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.1/domainjaeger-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ea4c86f919bd2e2ffa4b7f486a07c56710db4500fdf0c1cbc9a58c0c5d4b850"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "domainjaeger"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "domainjaeger"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "domainjaeger"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "domainjaeger"
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
