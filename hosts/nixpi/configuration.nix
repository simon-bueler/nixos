{ config, pkgs, lib, nixos-hardware, ... }:
{
  imports =
    [
      # ../../nixos/audio.nix
      # ../../nixos/auto-upgrade.nix
      # ../../nixos/bluetooth.nix
      #../../nixos/fonts.nix
      ../../nixos/home-manager.nix
      ../../nixos/network-manager.nix
      ../../nixos/nix.nix
      ../../nixos/timezone.nix
      #../../nixos/tuigreet.nix
      ../../nixos/users.nix
      ../../nixos/utils.nix
      ../../nixos/xdg-portal.nix
      ../../nixos/variables-config.nix
      ../../nixos/openssh.nix
      ../../themes/nixy.nix

      ./hardware-configuration.nix
      ./variables.nix
    ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  hardware = {
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      fkms-3d.enable = true;
    };

    deviceTree = {
      enable = true;
      filter = lib.mkForce "*rpi-4-*.dtb";
    };
  };

  # Enable audio devices
  boot.kernelParams = [ "snd_bcm2835.enable_hdmi=1" "snd_bcm2835.enable_headphones=1" ];

  # Prevent host becoming unreachable on wifi after some time.
  networking.networkmanager.wifi.powersave = false;

  # Mosh firewall port
  networking.firewall.allowedUDPPorts = [ 60001 ];

  #cachix for hyprland to avoid rebuild
  nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

  console.enable = false;
  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
  system.stateVersion = "24.11";
}
