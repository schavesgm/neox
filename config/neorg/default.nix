{ lib, config, ... }: {
  # Allow users to enable this module if wanted
  options = {
    neorg.enable = lib.mkEnableOption "Enable neorg module";
  };

  # Setup the module options
  config = lib.mkIf config.treesitter.enable {
    plugins.neorg = {
      enable = true;
      modules = {
        "core.defaults" = { 
	  __empty = null;
        };
      };
    };
  };
}
