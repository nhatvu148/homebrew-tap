class VideoTranscriberMcp < Formula
  desc "High-performance video transcription MCP server using whisper.cpp"
  homepage "https://github.com/nhatvu148/video-transcriber-mcp-rs"
  url "https://github.com/nhatvu148/video-transcriber-mcp-rs/archive/refs/tags/v0.9.0.tar.gz"
  # SHA256: curl -sL <url above> | shasum -a 256
  sha256 "dab4e8086d3119b70f85c1f5b55b5d811ffc4d465d4ca57ce722d3832de5bbf4"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_path_exists bin/"video-transcriber-mcp"
    # Actually run it: a binary that exists but won't start is still broken,
    # and this catches a build that produced an unusable artifact.
    assert_match version.to_s, shell_output("#{bin}/video-transcriber-mcp --version")
  end
end
