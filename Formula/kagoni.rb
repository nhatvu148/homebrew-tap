class Kagoni < Formula
  desc "Engine-agnostic Docker MCP server with token-bounded reads and gated writes"
  homepage "https://github.com/nhatvu148/kagoni"
  url "https://github.com/nhatvu148/kagoni/archive/v0.2.0.tar.gz"
  # To generate SHA256: curl -sL https://github.com/nhatvu148/kagoni/archive/v0.2.0.tar.gz | shasum -a 256
  sha256 "f4b4b62ca04177fbfc1e91a9a236c3a16a2739682bec4730e5e6ad441b4822a7"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  # Built WITH the `remote` feature, so ssh:// and https:// daemons work out of
  # the box. It costs ~34 extra crates and ~1.3 MB of binary, which is a real
  # trade for a published crate defaulting to the common case — but a Homebrew
  # user who has to discover mid-task that their install cannot reach a remote
  # host, and then rebuild via cargo, has been handed a worse deal than the
  # bytes were worth.
  def install
    system "cargo", "install", "--features", "remote", *std_cargo_args
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

      Remote daemons work with this build:

        kagoni --check --socket ssh://user@host

      Prefer ssh:// over exposing tcp://:2375, which is unauthenticated root
      on that machine.

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
