class Domainjaeger < Formula
  desc "Hunts for available domain names made of real words: cook.ing, sn.app, mike.ai"
  homepage "https://github.com/onehorizonai/domainjaeger"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.0/domainjaeger-aarch64-apple-darwin.tar.xz"
      sha256 "0dd2f436944f39230783937b882701a23447ca6a0efafd3693cf153a96dabaed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.0/domainjaeger-x86_64-apple-darwin.tar.xz"
      sha256 "1587d04d685ad6f5a0fe94ca367841803e8d165403cb2db9785fe360b3a68342"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.0/domainjaeger-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b52e4b0062a1060e0ecc9a547c46644ab50e3996250b8b6edaf7850c009deee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.3.0/domainjaeger-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19a494c7c9b303e868fcceede7e7cd5ab83e04dd385d2e3084d4b5e50de89544"
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
