{ pkgs, colourscheme, ... }:
let
  _ = rev: ref: repository: pkgs.vimUtils.buildVimPlugin {
    pname = "${pkgs.lib.strings.sanitizeDerivationName repository}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repository}.git";
      ref = ref;
      rev = rev;
    };
  };

in with pkgs.vimPlugins; [
  # Colourschemes bundled in the system
  catppuccin-nvim
  kanagawa-nvim

  # Treesitter
  nvim-treesitter.withAllGrammars
  nvim-treesitter-textobjects
  indent-blankline-nvim-lua
  rainbow-delimiters-nvim
  nvim-web-devicons

  # File-managers
  telescope-nvim

  # Autocompletion
  luasnip
  friendly-snippets
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp_luasnip
  cmp-emoji

  # Language server protocol
  nvim-lspconfig
  lspkind-nvim
  lspsaga-nvim
  conform-nvim

  # Status lines
  lualine-nvim

  # Movemement
  harpoon2
  flash-nvim

  # Git
  gitsigns-nvim
  neogit

  # CLI integration
  yazi-nvim
  glow-nvim
  octo-nvim

  # Useful plugins
  neorg
]
