# Nixvim is a NixOS module that installs and configures Neovim
{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
  };
}
