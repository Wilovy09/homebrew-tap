class GrowRs < Formula
  desc "🌱 Write sedders in RON"
  homepage "https://github.com/Wilovy09/Grow-rs"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/Grow-rs/releases/download/v3.0.0/grow-rs-aarch64-apple-darwin.tar.xz"
      sha256 "665abc89843eb38f812b885bfed2ef44c3ac55b69d3abd9f77c889c9ff372702"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/Grow-rs/releases/download/v3.0.0/grow-rs-x86_64-apple-darwin.tar.xz"
      sha256 "b8e82ebb31ce433f5934dbac16f8d6feaee9e901bf2232588e739ee44047ad8d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Wilovy09/Grow-rs/releases/download/v3.0.0/grow-rs-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "322929412cf691db7027ea96d611c31dc63dbfab1dbff4a65649e996ac3c31f2"
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
