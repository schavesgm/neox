{ lib, config, ... }: {
  # Import some colourschemes enabled in the configuration
  imports = [
    ./catppuccin.nix
  ];

  # Allow users to enable and disable this module
  # TODO: add option for selecting different colourschemes in the future
  options = {
    colourschemes.enable = lib.mkEnableOption "Enable colourschemes module";
  };

  # Add the modules to the configuration if enabled
  config = lib.mkIf config.colourschemes.enable {
    catppuccin.enable = lib.mkDefault true;
  };
}
