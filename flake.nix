{
  description = "Simple neovim flake";

  inputs = {
    # Add nixpkgs as a dependency of the system
    nixpkgs.url = "github:NixOS/nixpkgs";

    # Install neovim nightly
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, neovim, ... }: 
  let
    # Create an overlay to wrap the downloaded neovim
    overlayFlakeInputs = prev: final: {
      neovim = neovim.packages.x86_64-linux.neovim;
    };

    # Create an overlay wrapping the downloaded neovim with my configuration
    overlayNeovim = prev: final: {
      neox-nvim = import ./neox/package.nix { pkgs = final; };
    };

    # Add the overlays to the packages so that we can access the newly created package
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ overlayFlakeInputs overlayNeovim ];
    };
  in {
    packages.x86_64-linux.default = pkgs.neox-nvim;
    apps.x86_64-linux.default = {
      type = "app";
      program = "${pkgs.neox-nvim}/bin/nvim";
    };
  };
}
