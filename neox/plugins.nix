{ pkgs, ... }:
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

in {
  # These plugins will be automatically sourced at startup (can be slow)
  start = with pkgs.vimPlugins; [
    # Colourschemes bundled in the system
    catppuccin-nvim

    # Treesitter
    nvim-treesitter.withAllGrammars
    nvim-treesitter-textobjects
    indent-blankline-nvim-lua
    rainbow-delimiters-nvim
    nvim-web-devicons

    # Autocompletion
    luasnip
    friendly-snippets
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp_luasnip
    cmp-emoji
    cmp-git

    # Pickers
    telescope-nvim
    neorg-telescope

    # Language server protocol
    nvim-lspconfig
    lspkind-nvim
    lspsaga-nvim
    conform-nvim
    rustaceanvim

    # Status lines
    lualine-nvim

    # Movemement
    harpoon2
    flash-nvim

    # Git
    gitsigns-nvim

    # Useful plugins
    neorg

    # CLI integration
    octo-nvim
  ];

  # These plugins will be source when `:packadd ${plugin_name}` is called
  opt = with pkgs.vimPlugins; [
    # Git
    neogit

    # CLI integration
    yazi-nvim
  ];
}
