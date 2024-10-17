{ lib, config, ... }: {
  # Allow users to enable this module if wanted
  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };

  # Set the configuration of the module
  config = lib.mkIf config.git.enable {
    plugins = {
      neogit = {
        enable = true;
        settings = {
          integrations = {
            diffview = true;
          };
        };
      };
      diffview = { enable = true; };
      gitsigns = { enable = true; };
    };
  };
}
