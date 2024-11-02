{ config, ... }: {
  imports = [ ../../nixos/variables-config.nix ];

  config.var = {
    hostname = "nixSer4";
    username = "simon";
    password = "$y$j9T$KWxCw6L0CU.CezL75MlL7.$eNq00ZxucT8ioeXcf995nULGlTzvFGXtv9IknpU6602";
    sshAuthKey = "";
    configDirectory = "/home/" + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory


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

    autoUpgrade = false;
    autoGarbageCollector = false;

    theme = {
      rounding = 15;
      gaps-in = 3;
      gaps-out = 3 * 2;
      active-opacity = 1;
      inactive-opacity = 0.8;
      blur = true;
      border-size = 1;
      animation-speed = "medium"; # "fast" | "medium" | "slow"

      bar = {
        transparent = true;
        floating = true;
      };
    };
  };
}
