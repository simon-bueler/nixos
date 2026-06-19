{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.MbAirConfiguration = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.coreOptions
      inputs.nix-homebrew.darwinModules.nix-homebrew
      self.nixosModules.theme
    ];

    var = {
      hostname = "MacBookAir";
      username = "simon";
      password = "$y$j9T$KWxCw6L0CU.CezL75MlL7.$eNq00ZxucT8ioeXcf995nULGlTzvFGXtv9IknpU6602";
      sshAuthKey = "";
      configDirectory = "/Users/simon/.config/nixos";

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
        animation-speed = "medium";
      };
    };

    networking.hostName = config.var.hostname;

    users.users.${config.var.username} = {
      name = "${config.var.username}";
      home = "/Users/${config.var.username}";
    };

    system.primaryUser = "${config.var.username}";

    environment.systemPackages = with pkgs; [
      zed-editor
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";

    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = "${config.var.username}";
    };

    # Homebrew
    homebrew = {
      enable = true;
      brews = ["mas"];
      casks = ["fuse-t" "cryptomator"];
      masApps = {
        "WireGuard" = 1451685025;
      };
      onActivation.cleanup = "zap";
      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
    };

    # MacOS Defaults
    system.defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        expose-animation-duration = 0.2;
        tilesize = 48;
        launchanim = false;
        static-only = false;
        showhidden = true;
        show-recents = false;
        show-process-indicators = true;
        orientation = "bottom";
        mru-spaces = false;
        expose-group-apps = true;
        persistent-apps = [
          "/System/Applications/Mail.app"
          "/System/Applications/Messages.app"
          "/System/Applications/System Settings.app"
          "/Applications/Zen Browser.app"
          "${pkgs.zed-editor}/Applications/Zed.app"
          "${pkgs.wezterm}/Applications/WezTerm.app"
        ];
      };
      spaces.spans-displays = true;
      finder.FXPreferredViewStyle = "clmv";
      loginwindow.GuestEnabled = false;
      NSGlobalDomain.AppleICUForce24HourTime = true;
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      NSGlobalDomain.KeyRepeat = 2;
      NSGlobalDomain.AppleShowAllExtensions = true;
    };

    # Aerospace
    services.aerospace = {
      enable = true;
      settings = {
        mode.main.binding = {
          cmd-h = [];
          cmd-ctrl-h = [];
          ctrl-f = "fullscreen";
          ctrl-shift-period = "layout tiles horizontal vertical";
          ctrl-shift-comma = "layout accordion horizontal vertical";
          ctrl-h = "focus left";
          ctrl-j = "focus down";
          ctrl-k = "focus up";
          ctrl-l = "focus right";
          ctrl-shift-h = "move left";
          ctrl-shift-j = "move down";
          ctrl-shift-k = "move up";
          ctrl-shift-l = "move right";
          ctrl-up = "resize smart -50";
          ctrl-down = "resize smart +50";
          ctrl-1 = "workspace 1";
          ctrl-2 = "workspace 2";
          ctrl-3 = "workspace 3";
          ctrl-4 = "workspace 4";
          ctrl-5 = "workspace 5";
          ctrl-6 = "workspace 6";
          ctrl-7 = "workspace 7";
          ctrl-8 = "workspace 8";
          ctrl-9 = "workspace 9";
          ctrl-shift-1 = "move-node-to-workspace 1";
          ctrl-shift-2 = "move-node-to-workspace 2";
          ctrl-shift-3 = "move-node-to-workspace 3";
          ctrl-shift-4 = "move-node-to-workspace 4";
          ctrl-shift-5 = "move-node-to-workspace 5";
          ctrl-shift-6 = "move-node-to-workspace 6";
          ctrl-shift-7 = "move-node-to-workspace 7";
          ctrl-shift-8 = "move-node-to-workspace 8";
          ctrl-shift-9 = "move-node-to-workspace 9";
          ctrl-tab = "workspace-back-and-forth";
          ctrl-shift-tab = "move-workspace-to-monitor --wrap-around next";
          ctrl-shift-s = "mode service";
        };
        mode.service.binding = {
          esc = ["reload-config" "mode main"];
          r = ["flatten-workspace-tree" "mode main"];
          f = ["layout floating tiling" "mode main"];
          backspace = ["close-all-windows-but-current" "mode main"];
          ctrl-shift-h = ["join-with left" "mode main"];
          ctrl-shift-j = ["join-with down" "mode main"];
          ctrl-shift-k = ["join-with up" "mode main"];
          ctrl-shift-l = ["join-with right" "mode main"];
        };
      };
    };

    # Home Manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs self;};
      sharedModules = [
        inputs.mac-app-util.homeManagerModules.default
      ];
      users.${config.var.username} = {osConfig, ...}: {
        stylix.enableReleaseChecks = false;
        imports = [
          self.homeModules.git
          self.homeModules.shell
          self.homeModules.keyring
          self.homeModules.nvim
          self.homeModules.zed-editor
        ];
        home = {
          username = osConfig.var.username;
          homeDirectory = "/Users/${osConfig.var.username}";
          stateVersion = "24.05";
          packages = with pkgs; [
            nil
            alejandra
            mosh
          ];
        };
        programs.home-manager.enable = true;
      };
    };
  };
}
