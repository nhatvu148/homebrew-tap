class Kagoni < Formula
  desc "Engine-agnostic Docker MCP server with token-bounded reads and gated writes"
  homepage "https://github.com/nhatvu148/kagoni"
  url "https://github.com/nhatvu148/kagoni/archive/v0.1.0.tar.gz"
  # To generate SHA256: curl -sL https://github.com/nhatvu148/kagoni/archive/v0.1.0.tar.gz | shasum -a 256
  sha256 "74cba7eeb8922716f377a1da346fb750366a0e4484e494890c91a40a23dedc7b"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  # Default features only, matching `cargo install kagoni`. The `remote` feature
  # (ssh:// and https:// daemons) pulls in ~34 extra crates that a local-socket
  # user never touches; anyone who needs it can `cargo install kagoni --features remote`.
  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Register kagoni with Claude Code by adding this to .mcp.json in a project,
      or to ~/.claude.json to make it available everywhere:

        {
          "mcpServers": {
            "kagoni": { "command": "kagoni", "args": [] }
          }
        }

      Point it at a host you don't want an agent to change:

        kagoni --read-only

      Write tools are then absent from the tool list rather than refused.

      Check which engine it resolved before wiring it up:

        kagoni --check
    EOS
  end

  test do
    # Version reporting needs no daemon, so it works anywhere.
    assert_match "kagoni #{version}", shell_output("#{bin}/kagoni --version")

    # --check depends on whether the test machine happens to have a running
    # engine, so assert on what is true either way: it resolves one, or it
    # fails with the actionable message. Never a panic.
    output = `#{bin}/kagoni --check 2>&1`
    refute_match "panicked", output
    assert_match(/engine:|no container engine socket found/, output)
  end
end
