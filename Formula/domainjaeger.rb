class Domainjaeger < Formula
  desc "Hunts for available domain names made of real words: cook.ing, sn.app, mike.ai"
  homepage "https://github.com/onehorizonai/domainjaeger"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.2.0/domainjaeger-aarch64-apple-darwin.tar.xz"
      sha256 "162d4a27b273508baca8f3788456291fd56f948230897e60c7d4c58898315b90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.2.0/domainjaeger-x86_64-apple-darwin.tar.xz"
      sha256 "2ad4f1841b69d27b5f6aae178514a33dc1cd3bf7a977674efe82a2fe1473ba1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.2.0/domainjaeger-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2aa017571e9fe09715eeedca80a07400b35d97c444c44c6d21057150204d5bb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/onehorizonai/domainjaeger/releases/download/v0.2.0/domainjaeger-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb83357c96e6c943d064c221431b09bc97d132c42097c74003ceed918d45459c"
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
