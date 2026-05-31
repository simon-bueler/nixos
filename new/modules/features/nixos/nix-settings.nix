{self, ...}: {
  flake.nixosModules.nix-settings = {
    config,
    lib,
    ...
  }: let
    autoGarbageCollector = config.var.autoGarbageCollector or true;
  in {
    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = true;
    };
    nix = {
      extraOptions = ''
        warn-dirty = false
      '';
      settings = {
        download-buffer-size = 1073741824;
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        substituters = [
          "https://cache.nixos.org?priority=10"
          "https://hyprland.cachix.org"
        ];
        trusted-substituters = [
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
      gc = {
        automatic = autoGarbageCollector;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
