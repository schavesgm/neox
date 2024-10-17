{ lib, config, ... }: {
  # Allow the user to enable this module if wanted
  options = {
    mappings.enable = lib.mkEnableOption "Enable keymaps module";
  };

  # Set the default keymaps in the system
  config = lib.mkIf config.mappings.enable {
    globals.mapleader = ''\'';
    keymaps = [
      { action = ":bprevious<CR>"; key = "[b"; mode = "n"; options = { silent = true; }; }
      { action = ":bnext<CR>"; key = "]b"; mode = "n"; options = { silent = true; }; }
    ];
  };
}
