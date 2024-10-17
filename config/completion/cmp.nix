{ lib, pkgs, config, ... }: {
  # Allow users to enable this module if desired
  options = {
    cmp.enable = lib.mkEnableOption "Enable cmp module";
  };

  # Set the configuration of all cmp-related plugins
  config = lib.mkIf config.cmp.enable {
    plugins = {
      # Enable completion sources to use in the plugin
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp_luasnip.enable = true;

      # Enable luasnip as a snippets engine
      # TODO: add support for settings when neovim goes to 0.10 version in nix
      luasnip = {
        enable = true;
	    fromVscode = [
	      { lazyLoad = true; paths = "${pkgs.vimPlugins.friendly-snippets}"; }
	    ];
        fromLua = [
          { lazyLoad = true; paths = ./snippets; }
        ];
        # NOTE: add this in the next release
        # filetypeExtend = {
        #   "NeogitCommitMessage" = [ "gitcommit" ];
        # };
      };

      # Enable cmp as the autocompletion engine
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; keyword_length = 5; }
            { name = "path"; keyword_length = 3; }
            { name = "luasnip"; keyword_length = 3; }
          ];
          snippet = {
            expand = ''function(args) require("luasnip").lsp_expand(args.body) end'';
          };
          experimental = {
            ghost_text = true;
          };
          mapping = {
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";

            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  require("luasnip").expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").locally_jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<C-e>" = "cmp.mapping.abort()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";
          };
          # Enable pictogram icons for lsp/autocompletion
          formatting = {
            fields = [
              "kind"
              "abbr"
              "menu"
            ];
            expandable_indicator = true;
          };
          performance = {
            debounce = 60;
            fetching_timeout = 200;
            max_view_entries = 30;
          };
          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
            };
            documentation = {
              border = "rounded";
            };
          };
        };
      };
    };
  };
}
