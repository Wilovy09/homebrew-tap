class GrowRs < Formula
  desc "🌱 Write sedders in RON"
  homepage "https://github.com/Wilovy09/Grow-rs"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/Grow-rs/releases/download/v1.1.0/grow-rs-aarch64-apple-darwin.tar.xz"
      sha256 "f7fce6cb7a107561ef6ec40115a7c33b52c382b830ca53c7bd8c46edc8636ffc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/Grow-rs/releases/download/v1.1.0/grow-rs-x86_64-apple-darwin.tar.xz"
      sha256 "7c400297a0e4a0d59f5b6674eb67f16bda327bf454a6ce167d2f7a38550340b0"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Wilovy09/Grow-rs/releases/download/v1.1.0/grow-rs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c09dca13497a8e71b746296001642382b2915e85e995a4183a1afbb6cf7c5e8a"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "grow" if OS.mac? && Hardware::CPU.arm?
    bin.install "grow" if OS.mac? && Hardware::CPU.intel?
    bin.install "grow" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
