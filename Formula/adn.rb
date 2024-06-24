class Adn < Formula
  desc "🧬 The easy way to install LSP in Helix"
  homepage "https://github.com/Wilovy09/ADN"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.9/adn-aarch64-apple-darwin.tar.xz"
      sha256 "01b0cd5f671688874bfb1be778ae5cef1a3363f9b7d391d0b0acee72fbf510d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.9/adn-x86_64-apple-darwin.tar.xz"
      sha256 "a3deaf70b18d2e544df66e92a1deca5626defb538d03f4a02f03dca5458f588a"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Wilovy09/ADN/releases/download/v0.1.9/adn-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cd16fea223e73819299d055ef51cadd12f41605687f778a15b3b3120afbf519f"
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
