class X402McpProxy < Formula
  desc "Stdio MCP proxy that pays x402-gated MCP servers with USDC on Solana"
  homepage "https://github.com/nhatvu148/x402-mcp-proxy"
  # Sourced from crates.io rather than a GitHub tag: the repo is private, so a
  # GitHub archive URL would 404 for everyone but the owner. The .crate tarball
  # is public and immutable.
  # SHA256: curl -sL <url above> | shasum -a 256
  url "https://static.crates.io/crates/x402-mcp-proxy/x402-mcp-proxy-0.1.1.crate"
  sha256 "455285e7e634d749ba268035ab187a4c1ffee13f6e6fd5e785cdc81e344a03ee"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      The proxy needs a funded Solana wallet of its own:

        solana-keygen new --derivation-path -o ~/.config/solana/x402-payer.json

      Fund it with devnet USDC (faucet.circle.com) to try it, or real USDC on
      mainnet. Then register a paid server, e.g.:

        claude mcp add my-server -- x402-mcp-proxy \\
          --url https://your-server.example.com/mcp \\
          --keypair ~/.config/solana/x402-payer.json

      It holds a spendable wallet an agent can draw on, so keep --max-payments
      low (default 10). On mainnet also set
      X402_PROXY_RPC=https://api.mainnet-beta.solana.com — it defaults to devnet.
    EOS
  end

  test do
    assert_path_exists bin/"x402-mcp-proxy"
    # A binary that exists but won't start is still broken.
    assert_match version.to_s, shell_output("#{bin}/x402-mcp-proxy --version")
  end
end
