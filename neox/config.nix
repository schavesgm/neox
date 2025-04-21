{ pkgs }:
let
  neoxConfigDerivation = pkgs.stdenv.mkDerivation {
    name = "neox-config";
    src = ./config;
    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
    '';
  };
in
''
  let &runtimepath.=','."${neoxConfigDerivation}"

  source ${neoxConfigDerivation}/init.lua
''
