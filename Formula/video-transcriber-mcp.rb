class VideoTranscriberMcp < Formula
  desc "High-performance video transcription MCP server using whisper.cpp"
  homepage "https://github.com/nhatvu148/video-transcriber-mcp-rs"
  url "https://github.com/nhatvu148/video-transcriber-mcp-rs/archive/v0.7.0.tar.gz"
  # To generate SHA256: curl -sL https://github.com/nhatvu148/video-transcriber-mcp-rs/archive/v0.7.0.tar.gz | shasum -a 256
  sha256 "f8b6307c3e5da5028543566782053dd3d01f25b7d4efb81c4c10d1051b94ad38"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Test that binary exists
    assert_predicate bin/"video-transcriber-mcp", :exist?
  end
end
