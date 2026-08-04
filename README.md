# Homebrew Tap for nhatvu148's Tools

Personal Homebrew tap for my open-source tools.

## Usage

```bash
# Add this tap
brew tap nhatvu148/tap

# Install tools
brew install video-transcriber-mcp
brew install kagoni
```

Or install directly without tapping:

```bash
brew install nhatvu148/tap/video-transcriber-mcp
```

## Available Formulas

### kagoni

Engine-agnostic Docker MCP server with token-bounded reads and gated destructive writes.
Drives Docker, OrbStack, Podman or Colima through the plain Engine API.

- **GitHub**: https://github.com/nhatvu148/kagoni
- **crates.io**: https://crates.io/crates/kagoni

```bash
brew install nhatvu148/tap/kagoni
kagoni --check          # which engine did it resolve?
kagoni --read-only      # write tools removed, not merely refused
```

Register with Claude Code by adding to `.mcp.json`, or `~/.claude.json` for every project:

```json
{
  "mcpServers": {
    "kagoni": { "command": "kagoni", "args": [] }
  }
}
```

The formula builds with default features, matching `cargo install kagoni`. Remote daemons
over `ssh://` or `https://` need `cargo install kagoni --features remote` — those pull in
~34 extra crates a local-socket user never touches, so they are not in the brew build.

### video-transcriber-mcp

High-performance MCP server for transcribing videos from 1000+ platforms using whisper.cpp.

- **GitHub**: https://github.com/nhatvu148/video-transcriber-mcp-rs
- **crates.io**: https://crates.io/crates/video-transcriber-mcp

```bash
brew install nhatvu148/tap/video-transcriber-mcp
```

## More Tools Coming Soon!

