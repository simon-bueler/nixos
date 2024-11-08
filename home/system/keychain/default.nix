{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [ seahorse ];

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    extraFlags =
    [
      "--quiet"
    ];
  };
}
