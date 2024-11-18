{ pkgs, colourscheme, ... }: 
let
  neoxDependencies = pkgs.symlinkJoin {
      name = "neoxDependencies";
      paths = import ./dependencies.nix { inherit pkgs; };
  };

  # Select the correct colourscheme to load in the configuration
  default_colourscheme = let
    available_colourschemes = [ "catppuccin" "kanagawa" ];
  in
    if colourscheme == "catppuccin" then
      [ ''colorscheme catppuccin-macchiato'' ]
    else if colourscheme == "kanagawa" then
      [ ''colorscheme kanagawa'' ]
    else
      builtins.throw
        "Invalid colourscheme \"${colourscheme}\": [${builtins.toString available_colourschemes}]";

  # Construct our custom neox neovim wrapped package
  neoxNeovim = pkgs.wrapNeovim pkgs.neovim {
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    configure = {
      customRC = builtins.concatStringsSep 
        "\n" (default_colourscheme ++ (import ./config.nix { inherit pkgs; }));
      packages.all.start = import ./plugins.nix { inherit pkgs; inherit colourscheme; };
    };
  };
in pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neoxDependencies ];
  text = ''${neoxNeovim}/bin/nvim "$@"'';
}
