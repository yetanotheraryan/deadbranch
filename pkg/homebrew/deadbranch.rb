# Homebrew Formula for deadbranch
#
# This formula is available via:
#   brew install armgabrielyan/tap/deadbranch
#
# Or build from source:
#   brew install --HEAD armgabrielyan/tap/deadbranch

class Deadbranch < Formula
  desc "Clean up stale git branches safely"
  homepage "https://github.com/armgabrielyan/deadbranch"
  license "MIT"
  version "0.4.0" # x-release-please-version

  # Binary releases for different platforms
  on_macos do
    on_intel do
      url "https://github.com/armgabrielyan/deadbranch/releases/download/v#{version}/deadbranch-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "5acdc810a93066ec79c6edba4154d0427355ab7597301628be505b64c9f3fa22"
    end

    on_arm do
      url "https://github.com/armgabrielyan/deadbranch/releases/download/v#{version}/deadbranch-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a1e6769c15e47448db258c21d6540bd682f5673f061c85fdb35f4f453dec1cc4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/armgabrielyan/deadbranch/releases/download/v#{version}/deadbranch-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cea45cc8144dcc6e9ee9e2c6c94752366b77d6d3fe21181ff1dba014fc10d400"
    end

    on_arm do
      url "https://github.com/armgabrielyan/deadbranch/releases/download/v#{version}/deadbranch-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c90b3c80aa7ee0306b6dd953806343334161a348e9c44a207545abc7c64780c2"
    end
  end

  # Build from source (for --HEAD installs)
  head do
    url "https://github.com/armgabrielyan/deadbranch.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "deadbranch"
      man1.install "deadbranch.1"
    end
  end

  test do
    assert_match "deadbranch", shell_output("#{bin}/deadbranch --version")
  end
end
