{ lib, config, ... }: {
  # Allow users to enable this module if wanted
  options = {
    filesystem.enable = lib.mkEnableOption "Enable filesystem module";
  };

  # Set the configuration of the module
  config = lib.mkIf config.filesystem.enable {
    plugins = {
      nvim-tree = {
        enable = true;
      };
    };

    keymaps = [
      {
        action = ":NvimTreeToggle<CR>";
        key = "<leader>e";
        mode = "n";
        options = { silent = true; };
      }
    ];
  };
}
