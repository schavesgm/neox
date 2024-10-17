{
  description = "Neovim configuration using nixvim.";

  inputs = {
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixvim, flake-utils, ... } @ inputs:
  let
    config = import ./config; # import the module directly
  in
    flake-utils.lib.eachDefaultSystem (system:
    let
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs { inherit system; };
      nixvim' = nixvim.legacyPackages.${system};
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = config;
        extraSpecialArgs = { inherit self; };
      };
    in {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "neox";
        };
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nvim;
      };

      formatter = pkgs.alejandra;
    });
}
