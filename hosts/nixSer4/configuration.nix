{ pkgs, inputs, config, ... }: {
  imports = [
    ../../nixos/audio.nix
    ../../nixos/auto-upgrade.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/network-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/timezone.nix
    ../../nixos/tuigreet.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/xdg-portal.nix
    ../../nixos/variables-config.nix
    #../../nixos/openssh.nix

    #../../nixos/vm.nix

    ../../themes/nixy.nix

    ./hardware-configuration.nix
    ./disko-config.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".specific
  ];

  # Don't touch this
  system.stateVersion = "24.05";
}
