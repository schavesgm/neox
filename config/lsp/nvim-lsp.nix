{ lib, config, ... }: {
  # Configuration of this module
  options = {
    nvim-lsp.enable = lib.mkEnableOption "Enable nvim-lsp module";
  };

  # Configure the module
  config = lib.mkIf config.nvim-lsp.enable {
    plugins = {
      lsp = {
        enable = true;
        capabilities = ''offsetEncoding = "utf-16"'';

        # Define the keymaps to use in the LSP configuration
        keymaps = {
          silent = true;
          lspBuf = {
            "gd" = {
              action = "definition";
              desc = "Go to the symbol definition";
            };
            "gr" = {
              action = "references";
              desc = "Go to the symbol references";
            };
            "gD" = {
              action = "declaration";
              desc = "Go to the symbol declaration";
            };
            "gI" = {
              action = "implementation";
              desc = "Goto to the symbol implemenentation";
            };
            "gT" = {
              action = "type_definition";
              desc = "Go to the type definition";
            };
            "K" = {
              action = "hover";
              desc = "Hover information about the symbol";
            };
            "<leader>ws" = {
              action = "workspace_symbol";
              desc = "Get the workspace symbol";
            };
            "<leader>rn" = {
              action = "rename";
              desc = "Rename symbol";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Perform a code action on the line";
            };
            "<C-k>" = {
              action = "signature_help";
              desc = "Get help about a signature";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Show line diagnostics in a separate window";
            };
            "]d" = {
              action = "goto_next";
              desc = "Go to the next diagnostic in the buffer";
            };
            "[d" = {
              action = "goto_prev";
              desc = "Go to the previous diagnostic in the buffer";
            };
          };
        };

        # Define the servers to be used in the configuration
        servers = {
          # Lua language servers
          lua-ls = {
            enable = true;
            extraOptions = {
            };
            settings = {
              completion = {
                callSnippet = "Replace";
              };
              diagnostics = {
                globals = [ "vim" ];
              };
              hint = {
                enable = true;
              };
              telemetry = {
                enable = true;
              };
              workspace = {
                library = [
                  ''[vim.fn.expand("$VIMRUNTIME/lua")] = true''
                  ''[vim.fn.stdpath("config") .. "/lua"] = true''
                ];
              };
            };
          };

          # Python language servers
          ruff = {
            enable = true;
          };
          pylsp = {
            enable = true;
            settings = {
              pylsp = {
                plugins = {
                  jedi_completion = { enabled = true; };
                  jedi_definition = { enabled = true; };
                  jedi_hover = { enabled = true; };
                  jedi_references = { enabled = true; };
                  jedi_signature_help = { enabled = true; };
                  jedi_symbols = { enabled = true; };
                };
              };
            };
          };

          # Nix language servers
          nixd = {
            enable = true;
          };
        };
      };
    };
  };
}
