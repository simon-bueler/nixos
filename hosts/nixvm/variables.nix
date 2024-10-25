{ config, ... }: {
  imports = [ ../../nixos/variables-config.nix ];

  config.var = {
    hostname = "nixvm";
    username = "simon";
    password = "$y$j9T$KWxCw6L0CU.CezL75MlL7.$eNq00ZxucT8ioeXcf995nULGlTzvFGXtv9IknpU6602";
    sshAuthKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDR+T1PquhilDYrqDMaPyph4qnP1yraCaURc5NN500HIVyAe5otUp0bEY06uBgTI/SfdLnKzmNKwTDZD3wOaF5VrWd3ynBJXvq3b9Wrgi3q2pLVjZR30NVw9QQ/EHf5DDqcKjPywLagaIDndUjQSVdTlrILp7y8QEo0Y335oPvhlLCdILNucJZnwAJSRN+hKFaqi+ruPbLnuBuxWnH7VhozpZrb/7mFt4nqnRwPawbhH+EWW1bXuNA8hcAijDyKCirdoRwM08tDzLmfhKVxNhSbBj5bIMjXe6M8XeYR3r65PoghGWsCmRnGY5juXSZKPWyDrf9SEl+L5Y0Tgae2bTWaV61DkTj2ix6NDg+Hc9XG+lDf+tXXiWEixec+RmBp2Ve9a+JIy0huvpukV6rR3Sh5LoWzmfa4kNgo+cceildtQkJuIJlBiujoEMKsyqKP/hK4EbZNZDjnBNn0b6LSa1r02ToDt1Wlfn/gi3PUu14i/pciugtOL1ZKutDxdur+cuYZEAEADB1zf+CRPjnNzyws4Bhcx4XsFq4SXchxtB7S7YXng18x2KFabb6zjVwEfoJHE1pVJ2Ce/7r/gEfIupTQkWaDDe+z6g6eZiTLmko62jTdTjr3cSIgh1MLpvtUlEm1gJaoIEQkIo35ZmEZZMuNB8rbGWETRAxx4p4YnNGZFQ== simon.bueeler@icloud.com";
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
      fetch = "neofetch"; # "nerdfetch" | "neofetch" | "pfetch" | "none"

      bar = {
        transparent = true;
        floating = true;
      };
    };
  };
}
