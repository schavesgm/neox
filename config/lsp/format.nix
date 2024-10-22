{ lib, config, ... }:
{
  options = {
    format.enable = lib.mkEnableOption "Enable formatting module";
  };

  config = lib.mkIf config.format.enable {
    # Enable the formatting plugin -- conform-nvim
    plugins.conform-nvim = {
      enable = true;
    };

    # Set the command used to generate the 
    extraConfigLua = ''
      -- NOTE: this should be delegated to the plugin itself in the future
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format" },
        }
      }

      vim.api.nvim_create_user_command("Format",
        function(command_args)
          -- Get the range used by the command from the command arguments
          local range = nil
          if command_args.count ~= -1 then
            local end_line =
              vim.api.nvim_buf_get_lines(0, command_args.line2 - 1, command_args.line2, true)[1]
            range = {
              start = { command_args.line1, 0 }, ["end"] = { command_args.line2, end_line:len() }
            }
          end
          -- Run conform to format the document
          require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end,
        { range = true }
      )
    '';
  };
}
