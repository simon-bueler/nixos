{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      ignore = ["yaml"];
    };
  };
}
