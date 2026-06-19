{self, ...}: {
  flake.nixosModules.core = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.coreOptions
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;

    # Global system packages
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
      curl
    ];

    # Basic system configuration
    networking.networkmanager.enable = true;
    time.timeZone = lib.mkDefault "Europe/Zurich";
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  };
}
