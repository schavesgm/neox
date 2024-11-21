{ pkgs }: 
with pkgs; [
  # Language servers
  ruff
  pyright
  lua-language-server
  marksman
  nixd

  # Install some Rust related libraries
  rust-analyzer
  cargo

  # Install clang and clang-tools to have access to clangd
  clang
  clang-tools

  # Command line tools
  ripgrep
  glow
  yazi
  github-cli
]
