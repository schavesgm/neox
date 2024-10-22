{ pkgs }: 
let
  neoxDependencies = pkgs.symlinkJoin {
      name = "neoxDependencies";
      paths = import ./dependencies.nix { inherit pkgs; };
  };

  neoxNeovim = pkgs.wrapNeovim pkgs.neovim {
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    configure = {
      customRC = import ./config.nix { inherit pkgs; };
      packages.all.start = import ./plugins.nix { inherit pkgs; };
    };
  };
in pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neoxDependencies ];
  text = ''${neoxNeovim}/bin/nvim "$@"'';
}
