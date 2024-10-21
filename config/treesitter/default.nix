{ lib, config, ... }: {
  # Allow users to enable this module if wanted
  options = {
    treesitter.enable = lib.mkEnableOption "Enable treesitter module";
  };

  # Set the configuration of the module
  config = lib.mkIf config.treesitter.enable {
    plugins = {
      # Enable basic tree-sitter module
      # TODO: add support for settings when neovim reaches 0.10 version in nix
      treesitter = {
        enable = true;
        nixvimInjections = true;
      };

      # Add treesitter textobjects
      treesitter-textobjects = {
        enable = true;
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "ii" = "@conditional.inner";
            "ai" = "@conditional.outer";
            "il" = "@loop.inner";
            "al" = "@loop.outer";
            "at" = "@comment.outer";
          };
        };
        move = {
          enable = true;
          gotoNextStart = {
            "]m" = "@function.outer";
            "]]" = "@class.outer";
          };
          gotoNextEnd = {
            "]M" = "@function.outer";
            "][" = "@class.outer";
          };
          gotoPreviousStart = {
            "[m" = "@function.outer";
            "[[" = "@class.outer";
          };
          gotoPreviousEnd = {
            "[M" = "@function.outer";
            "[]" = "@class.outer";
          };
        };
        swap = {
          enable = true;
          swapNext = {
            "<leader>a" = "@parameters.inner";
          };
          swapPrevious = {
            "<leader>A" = "@parameter.outer";
          };
        };
      };

      # Add indent blankline plugin
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
          };
        };
      };

      # Add some tree-sitter related plugins
      # NOTE: add support for nvim-devicons once neovim version is bumped to 0.10
      rainbow-delimiters = {
        enable = true;
      };
      ts-autotag = {
        enable = true;
      };
      treesitter-context = {
        enable = true;
        settings = {
          enable = false;
        };
      };
      ts-context-commentstring = { 
        enable = true;
	    disableAutoInitialization = false;
      };
    };

    # Add some keymaps related to tree-sitter manipulation
    keymaps = [
      {
        action = ":TSContextToggle<CR>";
        key = "<leader>c";
        mode = "n";
        options = { silent = true; };
      }
    ];
  };
}
