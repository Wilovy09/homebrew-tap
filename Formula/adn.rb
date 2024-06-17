class Adn < Formula
  desc "🧬 The easy way to install LSP in Helix"
  homepage "https://github.com/Wilovy09/ADN"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.5/adn-aarch64-apple-darwin.tar.xz"
      sha256 "f3bcb59448b673646f2c5781e0f8fbeba4e1d2a8bc7d4caf46529f200ce49824"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.5/adn-x86_64-apple-darwin.tar.xz"
      sha256 "aed3d98abb6da98a1bc3cf523c2f18a0f8ad3915c80036b5b2e68d8f37af3252"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.5/adn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54b076c77f008cb003b10cdbb0911fd991b14204ed959acd4ae826bbe4ed3bdd"
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
