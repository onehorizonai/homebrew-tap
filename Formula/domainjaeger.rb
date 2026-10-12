class Domainjaeger < Formula
  desc "Hunts for available domain names made of real words: cook.ing, sn.app, mike.ai"
  homepage "https://github.com/onehorizonai/domainjaeger"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.1.0/domainjaeger-aarch64-apple-darwin.tar.xz"
      sha256 "45c2747f71ae62212729e07bab29c688ab7890d3de8bcba95320c3980feb34f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.1.0/domainjaeger-x86_64-apple-darwin.tar.xz"
      sha256 "15703286f6e343e18c523e4e98e31112b4fbd6c9dce07bc74ac337648b8f76e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.1.0/domainjaeger-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "801811313179af34a0c6ee706e8fde0b8462423570d7f29a07ff74afe4c0b906"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.1.0/domainjaeger-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4bdf2a5837c48749afa2d564da5333b7b41989e5a7efc641ff934bc42d52d4a2"
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
