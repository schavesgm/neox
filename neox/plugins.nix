{ pkgs, ... }:
let
  fetchFromGithub =
    rev: ref: repository:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${pkgs.lib.strings.sanitizeDerivationName repository}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repository}.git";
        ref = ref;
        rev = rev;
      };
    };
in
{
  # These plugins will be automatically sourced at startup (can be slow)
  start = with pkgs.vimPlugins; [
    # Colourschemes bundled in the system
    catppuccin-nvim
    (fetchFromGithub "f0ff26080318013fd79a34b57d2937b7b4c5618b" "main" "jackplus-xyz/binary.nvim")

    # Treesitter
    # NOTE: install `norg_meta` separately because it is not present in `allGrammars` 😭
    (nvim-treesitter.withPlugins (
      _:
      nvim-treesitter.allGrammars
      ++ [
        (pkgs.tree-sitter.buildGrammar {
          language = "norg_meta";
          version = "6f0510c";
          src = (
            fetchFromGithub "6f0510cc516a3af3396a682fbd6655486c2c9d2d" "main" "nvim-neorg/tree-sitter-norg-meta"
          );
        })
      ]
    ))
    indent-blankline-nvim-lua
    rainbow-delimiters-nvim
    nvim-web-devicons

    # Movement
    mini-ai
    mini-surround

    # Autocompletion and snippets
    blink-cmp
    luasnip
    friendly-snippets

    # Pickers
    fzf-lua

    # Language server protocol
    nvim-lspconfig
    lspkind-nvim
    lspsaga-nvim
    conform-nvim
    rustaceanvim

    # AI-integrations
    avante-nvim

    # Status lines
    lualine-nvim

    # Movemement
    flash-nvim

    # Git
    gitsigns-nvim
    neogit

    # Useful plugins
    neorg

    # CLI integration
    octo-nvim
  ];

  # These plugins will be source when `:packadd ${plugin_name}` is called
  opt = [ ];
}
