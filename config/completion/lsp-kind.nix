{ lib, config, ... }: {
  # Set some options to configure this module
  options = {
    lsp-kind.enable = lib.mkEnableOption "Enable lspkind module";
  };

  # Set the module configuration
  config = lib.mkIf config.lsp-kind.enable {
    plugins.lspkind = {
      enable = true;
      symbolMap = {
        Copilot = "";
      };
      extraOptions = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };
  };
}
