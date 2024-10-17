{ lib, config, ... }: {
  # Allow users to enable this module if wanted
  options = {
    statusline.enable = lib.mkEnableOption "Enable statusline module";
  };

  # Set the configuration of the module
  config = lib.mkIf config.statusline.enable {
    plugins = {
      lualine = {
        enable = true;
      };
    };
  };
}
