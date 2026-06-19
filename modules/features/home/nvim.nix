{self, ...}: {
  flake.homeModules.nvim = {
    config,
    pkgs,
    ...
  }: let
    nvimWritableDir = "/home/${config.home.username}/.local/share/nvim-writable";
  in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;
      withPython3 = false;
    };

    home.file.".config/nvim" = {
      source = pkgs.fetchFromGitHub {
        owner = "simon-bueler";
        repo = "init.lua";
        rev = "master";
        sha256 = "U+8S9ZDbBIR/7tFVXrZ+vm5JwsVn+wJGOIJf4TNcMjA=";
      };
      recursive = true;
    };

    home.activation.makeLazyLockWritable = config.lib.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${nvimWritableDir}
      $DRY_RUN_CMD rm -f $VERBOSE_ARG ~/.config/nvim/lazy-lock.json
      $DRY_RUN_CMD ln -sf $VERBOSE_ARG ${nvimWritableDir}/lazy-lock.json ~/.config/nvim/lazy-lock.json
    '';

    home.packages = with pkgs; [
      git
      wget
      curl
      fd
      ripgrep
      fzf
      lazygit
      gcc
      tree-sitter
      nodejs
      python3
      unzip
      luarocks
      lua5_1
      go
      rust-analyzer
      nil
      lua-language-server
      gopls
    ];
  };
}
