{
  config,
  pkgs,
  ...
}: let
  nvimWritableDir = "/home/simon/.local/share/nvim-writable";
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "simon-bueler";
      repo = "init.lua";
      rev = "master"; # oder einen spezifischen commit hash
      sha256 = "U+8S9ZDbBIR/7tFVXrZ+vm5JwsVn+wJGOIJf4TNcMjA="; # Zuerst mit falschem hash, dann korrigieren
    };
    recursive = true;
  };

  # Make lazy-lock.json and other generated files writable
  home.activation.makeLazyLockWritable = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p ${nvimWritableDir}

    # Replace lazy-lock.json with symlink to writable location
    $DRY_RUN_CMD rm -f $VERBOSE_ARG ~/.config/nvim/lazy-lock.json
    $DRY_RUN_CMD ln -sf $VERBOSE_ARG ${nvimWritableDir}/lazy-lock.json ~/.config/nvim/lazy-lock.json
  '';

  home.packages = with pkgs; [
    # Essential tools for the config
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

    # LSP servers
    rust-analyzer
    nil
    lua-language-server
    gopls
  ];
}
