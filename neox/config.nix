{ pkgs }:
let
  # Function transforming configuration files into its own derivation to be used by the system
  buildModule =
    directory:
    let
      config-dir = pkgs.stdenv.mkDerivation {
        name = "neox-${directory}-configuration";
        src = ./lua/${directory};
        installPhase = ''
          mkdir -p $out/
          cp ./* $out/
        '';
      };
    in
    builtins.map (file: "${config-dir}/${file}") (builtins.attrNames (builtins.readDir config-dir));

  # Create the configuration derivation and use it in the main body of the function
  neox = builtins.concatLists [
    (buildModule "base")
    (buildModule "plugins")
    (buildModule "lsp")
    (buildModule "snippets")
  ];
in
builtins.map (file: "source ${file}") neox
