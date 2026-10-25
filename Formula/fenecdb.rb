# Written by tools/homebrew-formula.py in fenecdb/fenecdb from release v0.1.12's
# SHA256SUMS, not by hand: `--check` writes it again from the same release and
# compares, and `--verify` holds its sums to the release's files.
class Fenecdb < Formula
  desc "Embedded database with its own query language, FenecQL"
  homepage "https://fenecdb.com"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/fenecdb/fenecdb/releases/download/v0.1.12/fenec-v0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "55e50789bc9a836c07d63d7ce220fbb7c8134248ea4bae113d677f8ab8bad7d5"
    end
    on_intel do
      url "https://github.com/fenecdb/fenecdb/releases/download/v0.1.12/fenec-v0.1.12-x86_64-apple-darwin.tar.gz"
      sha256 "68cbd8efcf14d1a635d16237430395b54a3f254cb4f49e37465785179c549afa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fenecdb/fenecdb/releases/download/v0.1.12/fenec-v0.1.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8b20b4fb42a45d15b03b202c486dc2b971f3bf6b7e112d4d9c18e61499339dcd"
    end
    on_intel do
      url "https://github.com/fenecdb/fenecdb/releases/download/v0.1.12/fenec-v0.1.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a2dffc17ed94ef162feb2974260fb2f95640a9f49944aa78cdee4f53b9709387"
    end
  end

  def install
    bin.install "fenec", "fenec-server"
  end

  test do
    # Neither binary has a version flag: fenec-server names its version on the
    # first line of --help, and the shell is run on a script, in memory.
    assert_match "fenec-server #{version}", shell_output("#{bin}/fenec-server --help 2>&1")
    script = "create collection t (n int)\nput t {id: 1, n: 7}\nget t\n"
    assert_match(/^1\s+7$/, pipe_output("#{bin}/fenec", script))
  end
end
