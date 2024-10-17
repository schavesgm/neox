{ lib, config, ... }: {
  imports = [
    ./cmp.nix
    ./lsp-kind.nix
  ];

  # Allow users to enable this module if wanted
  options = {
    completion.enable = lib.mkEnableOption "Enable completion module";
  };

  # Set the configuration of the module
  config = lib.mkIf config.completion.enable {
    cmp.enable = lib.mkDefault true;
    lsp-kind.enable = lib.mkDefault true;
  };
}
