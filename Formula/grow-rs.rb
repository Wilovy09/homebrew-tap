class GrowRs < Formula
  desc "🌱 Write sedders in RON"
  homepage "https://github.com/Wilovy09/Grow-rs"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/Grow-rs/releases/download/v2.0.0/grow-rs-aarch64-apple-darwin.tar.xz"
      sha256 "e4ef83e99afc24dd1690062c89479c5a33965e82fcfcf45b2c5bc7363f45fbbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/Grow-rs/releases/download/v2.0.0/grow-rs-x86_64-apple-darwin.tar.xz"
      sha256 "51e0683df6c88cd832b852d4344ba57f57e0b9a8ffec33abf7131fb39830683a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Wilovy09/Grow-rs/releases/download/v2.0.0/grow-rs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8c444fff9b7889adc80804c9fb449d3b10d31ddd298b347e8db24ca62ff549a9"
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
