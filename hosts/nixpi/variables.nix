{ config, ... }: {
  imports = [ ../../nixos/variables-config.nix ];

  config.var = {
    hostname = "nixpi";
    username = "simon";
    password = "$y$j9T$KWxCw6L0CU.CezL75MlL7.$eNq00ZxucT8ioeXcf995nULGlTzvFGXtv9IknpU6602";
    sshAuthKey = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDR+T1PquhilDYrqDMaPyph4qnP1yraCaURc5NN500HIVyAe5otUp0bEY06uBgTI/SfdLnKzmNKwTDZD3wOaF5VrWd3ynBJXvq3b9Wrgi3q2pLVjZR30NVw9QQ/EHf5DDqcKjPywLagaIDndUjQSVdTlrILp7y8QEo0Y335oPvhlLCdILNucJZnwAJSRN+hKFaqi+ruPbLnuBuxWnH7VhozpZrb/7mFt4nqnRwPawbhH+EWW1bXuNA8hcAijDyKCirdoRwM08tDzLmfhKVxNhSbBj5bIMjXe6M8XeYR3r65PoghGWsCmRnGY5juXSZKPWyDrf9SEl+L5Y0Tgae2bTWaV61DkTj2ix6NDg+Hc9XG+lDf+tXXiWEixec+RmBp2Ve9a+JIy0huvpukV6rR3Sh5LoWzmfa4kNgo+cceildtQkJuIJlBiujoEMKsyqKP/hK4EbZNZDjnBNn0b6LSa1r02ToDt1Wlfn/gi3PUu14i/pciugtOL1ZKutDxdur+cuYZEAEADB1zf+CRPjnNzyws4Bhcx4XsFq4SXchxtB7S7YXng18x2KFabb6zjVwEfoJHE1pVJ2Ce/7r/gEfIupTQkWaDDe+z6g6eZiTLmko62jTdTjr3cSIgh1MLpvtUlEm1gJaoIEQkIo35ZmEZZMuNB8rbGWETRAxx4p4YnNGZFQ== simon.bueeler@icloud.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEgi7e99PLaFck2nUUctYQKphgNciowzR7t0jcUd85ZoLsVx9JbvRyqS5nnVEj/Ptolb1OS8mAmhPbFL7tGIhaJVtdtdPeQsP3xGYYqxWySxVnhCAuT3xVOVEcLTRarhNVBl+8yrZMVoSfkIfrHVedEfM9D2MohPAtkY7cHdr3Fqmt37p6MHkcn0bXm2Asw2LBU0gKfpFAmIXsoqQAI/SUFfuTK3wCtHE4vUY3/HDv/Xh8wFkRztUGcvC5EDNNQIgX9aW2OIMm+OHTQ22PUXqo0yXFFKm8Hqn4OsyqHoQvZylQJGcm3rjSC8jpKXUCsvqqkc4E9xArbkCceJ6SECFqKX1YvyZw4avKuqkFHJOlTZbBnG6DuxaBnn/Z0+d+XR/kkkx8ZbbVUCC2YI82BNS0qMeKryuoGdm22kZ3rr63UQveYK+WOAHgWo7OlrKcZl3SqnExmkp3eUEpGKW0a/Zbpgivdj5wzqLUiOXUqkOxvYoq9pjkUff2z0yOsfW1lxgThs38Bo1KEZg8tUcvsVbWxk51IXeFnJiF+gTjh+pWGnCw5gXATow+LqwJ8q1xSKpacysjONhueSi4od9b4nxK6a/ou1a9nUDZOrw1Wjcm+Uaeq+yfnmcC0D4VQ89jFWO0H8finS33iRyNQOhpLcKppFhNCcouSXpfbMECfrf6iQ== Destrukto-Laptop"
    ];
    configDirectory = "/home/" + config.var.username + "/.config/nixos"; # The path of the nixos configuration directory


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
    autoGarbageCollector = true;

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
