{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/shell
    ../../home/programs/shell/zsh-nixos.nix
    ../../home/programs/git
    ../../home/programs/yazi
    ../../home/programs/markdown
    ../../home/programs/thunar
    ../../home/programs/zed-editor
    ../../home/programs/mpv
    ../../home/programs/streamcontroller

    # Scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/hypridle
    ../../home/system/hyprlock
    ../../home/system/hyprpanel
    ../../home/system/hyprpaper
    ../../home/system/hyprswitch
    ../../home/system/wofi
    #../../home/system/batsignal
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    ../../home/system/clipman
    ../../home/system/syncthing
    ../../home/system/keychain
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      vesktop
      feishin
      element-desktop
      freefilesync
      inputs.zen-browser.packages."${system}".default

      # Dev
      nil
      alejandra
      # go
      # nodejs
      # python3
      # jq
      # figlet

      # Utils
      zip
      unzip
      optipng
      pfetch
      pandoc
      btop
      lunarvim
      mosh
      spotdl
      mediainfo
      moonlight-qt

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix
      cava

      # Backup
      firefox
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".profile_picture.png" = {source = ./profile_picture.jpeg;};

    # Import my wallpaper, used by the hyprpanel dashboard

    # Don't touch this
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
