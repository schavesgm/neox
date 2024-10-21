{ lib, pkgs, config, ... }: {
  # Import some modules of the configuration
  imports = [
    ./base-options
    ./mappings
    ./colourschemes

    ./completion
    ./filesystem
    ./git
    ./lsp
    ./neorg
    ./statusline
    ./telescope
    ./treesitter
  ];


  # Enable some basic modules from the configuration
  base-options.enable = true;
  mappings.enable = true;
  colourschemes.enable = true;

  # Enable some plugins
  completion.enable = true;
  filesystem.enable = true;
  git.enable = true;
  lsp.enable = true;
  neorg.enable = true;
  statusline.enable = true;
  telescope.enable = true;
  treesitter.enable = true;

  # Add support for neorg in neovim 24.05
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      inherit (pkgs.luaPackages.lua-utils-nvim) pname version src;
    })

    (pkgs.vimUtils.buildVimPlugin {
      inherit (pkgs.luaPackages.pathlib-nvim) pname version src;
    })

    (pkgs.vimUtils.buildVimPlugin {
      inherit (pkgs.luaPackages.nvim-nio) pname version src;
    })
  ];
}
