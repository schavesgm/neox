{ pkgs }: 
with pkgs; [
  # Language servers
  ruff
  pyright
  lua-language-server
  marksman
  nixd

  # Command line tools
  ripgrep
  glow
  yazi
  github-cli
]
