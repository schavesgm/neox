{ pkgs }:
let
  # Function transforming configuration files into its own derivation to be used by the system
  buildModule = directory:
    let
      configDir = pkgs.stdenv.mkDerivation {
        name = "neox-${directory}-configuration";
        src = ./lua/${directory};
        installPhase = ''
          mkdir -p $out/
          cp ./* $out/
        '';
      };
    in 
      builtins.map 
        (file: "${configDir}/${file}")
        (builtins.attrNames (builtins.readDir configDir));

  # Function concatenating all the configuration files and then sourcing them
  sourceConfigFiles = files:
    builtins.concatStringsSep "\n" (builtins.map (file: "source ${file}") files);

  # Create the configuration derivation and use it in the main body of the function
  neox = builtins.concatLists [
    (buildModule "base")
    (buildModule "plugins")
    (buildModule "lsp")
    (buildModule "snippets")
  ];
in sourceConfigFiles neox
