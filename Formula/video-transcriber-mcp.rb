class VideoTranscriberMcp < Formula
  desc "High-performance video transcription MCP server using whisper.cpp"
  homepage "https://github.com/nhatvu148/video-transcriber-mcp-rs"
  url "https://github.com/nhatvu148/video-transcriber-mcp-rs/archive/refs/tags/v0.10.1.tar.gz"
  # SHA256: curl -sL <url above> | shasum -a 256
  sha256 "20fa806e086dfe9cf2d48aaa7845c57123323226e4a8837893f9fa19056cd947"
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
