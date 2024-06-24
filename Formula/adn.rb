class Adn < Formula
  desc "🧬 The easy way to install LSP in Helix"
  homepage "https://github.com/Wilovy09/ADN"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.8/adn-aarch64-apple-darwin.tar.xz"
      sha256 "78965b7105facd6e589964ee9703765296faadb389a0246c56e024b7b88ce109"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.8/adn-x86_64-apple-darwin.tar.xz"
      sha256 "f74dfd93925818799a16be785fce8f8e6c911d5d97470543f18fa3e6e30e792d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.8/adn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5431746900cc99cbaee3546fa9b9a9905442f3d45891555010cce3ef6a580892"
    end
  end
  license "MIT"

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "adn"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "adn"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "adn"
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
