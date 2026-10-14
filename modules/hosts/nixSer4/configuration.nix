{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nixSer4Configuration = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.core
      self.nixosModules.nixSer4Hardware

      # Features
      self.nixosModules.users
      self.nixosModules.audio
      self.nixosModules.networking
      self.nixosModules.bluetooth
      self.nixosModules.sddm
      self.nixosModules.fonts
      self.nixosModules.tailscale
      self.nixosModules.utils
      self.nixosModules.xdg-portal
      self.nixosModules.nix-settings
      self.nixosModules.systemd-boot
      self.nixosModules.timezone
      self.nixosModules.openssh
      self.nixosModules.home-manager
      self.nixosModules.theme
      self.nixosModules.niri

      # Disko
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.nixSer4
    ];

    # Host specific variables (migrated from hosts/nixSer4/variables.nix)
    var = {
      hostname = "nixSer4";
      username = "simon";
      password = "$y$j9T$KWxCw6L0CU.CezL75MlL7.$eNq00ZxucT8ioeXcf995nULGlTzvFGXtv9IknpU6602";
      sshAuthKey = "";
      configDirectory = "/home/simon/.config/nixos";
      autoGarbageCollector = true;

      keyboardLayout = "ch";
      consoleLayout = "sg";

      location = "Luzern";
      timeZone = "Europe/Zurich";
      defaultLocale = "de_CH.UTF-8";
      extraLocale = "en_US.UTF-8";

      git = {
        username = "simon-bueler";
        email = "simon.bueeler@icloud.com";
      };

      theme = {
        rounding = 15;
        gaps-in = 3;
        gaps-out = 6;
        active-opacity = 1;
        inactive-opacity = 0.8;
        blur = true;
        border-size = 1;
        animation-speed = "fast";
      };
    };

    networking.hostName = config.var.hostname;

    # Home Manager configuration for the user
    home-manager = {
      backupFileExtension = "backup";
      users.${config.var.username} = {
        stylix.enableReleaseChecks = false;
        imports = [
          self.homeModules.nvim
          self.homeModules.git
          self.homeModules.shell
          self.homeModules.yazi
          self.homeModules.kitty
          self.homeModules.imv
          self.homeModules.mime
          self.homeModules.mpv
          self.homeModules.zen-browser
          self.homeModules.zed-editor
          self.homeModules.vis
          self.homeModules.syncthing
          self.homeModules.zathura
          self.homeModules.thunar
          self.homeModules.udiskie
        ];

        home = {
          username = config.var.username;
          homeDirectory = "/home/${config.var.username}";
          stateVersion = "24.05";

          packages = with pkgs; [
            # Add any host-specific packages here if needed
            vesktop
            feishin
            element-desktop
            freefilesync
            localsend
            calibre
            #hakuneko
            kcc
            alejandra
            antigravity-cli
            terraform
            talosctl
            talhelper
            sops
            age
            omnictl
            zip
            unzip
            optipng
            pfetch
            pandoc
            btop
            mosh
            spotdl
            deno
            mediainfo
            moonlight-qt
            streamcontroller
            peaclock
            cbonsai
            pipes
            cmatrix
            cava
            firefox
          ];

          file.".face.icon".source = ./profile_picture.jpeg;
        };
        programs.home-manager.enable = true;
      };
    };

    # Printing and Avahi (from original new/modules/hosts/nixSer4/configuration.nix)
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    networking.firewall.allowedTCPPorts = [22000 8384];
    networking.firewall.allowedUDPPorts = [22000 21027];
    virtualisation.podman.enable = true;

    system.stateVersion = "24.05";
  };
}
