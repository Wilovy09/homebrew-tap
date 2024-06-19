class Adn < Formula
  desc "🧬 The easy way to install LSP in Helix"
  homepage "https://github.com/Wilovy09/ADN"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.6/adn-aarch64-apple-darwin.tar.xz"
      sha256 "55b07925df7e99000b8570895db59a38f02756f8e8a179d2b87f2ab928586598"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.6/adn-x86_64-apple-darwin.tar.xz"
      sha256 "4b9c3fcacb48a08a63b196e69a7c5e632d68326c09438b0b7c8012f1aadb805f"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.6/adn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5ca0b6c0ca6f987b55884e96e9d0216b4ff771fc4c141623850ebf1d3c568732"
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
