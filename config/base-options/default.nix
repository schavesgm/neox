{ lib, config, ... }: {
  # Allow the user to enable this module if wanted
  options = {
    base-options.enable = lib.mkEnableOption "Enable options module";
  };

  # Set the default keymaps in the system
  config = lib.mkIf config.base-options.enable {
    extraConfigLua = lib.readFile ./options.lua;
  };
}
