{ lib, config, ... }: {
  # Import some modules from the configuration
  imports = [
    ./format.nix
    ./lsp-saga.nix
    ./nvim-lsp.nix
  ];

  # Allow users to enable this module if wanted
  options = {
    lsp.enable = lib.mkEnableOption "Enable LSP module";
  };

  # Set the configuration of the module
  config = lib.mkIf config.lsp.enable {
    nvim-lsp.enable = lib.mkDefault true;
    lsp-saga.enable = lib.mkDefault true;
    format.enable = lib.mkDefault true;
  };
}
