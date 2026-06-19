{
  self,
  pkgs,
  config,
  lib,
  ...
}: {
  flake.nixosModules.utils = {
    pkgs,
    config,
    ...
  }: let
    keyboardLayout = config.var.keyboardLayout;
    consoleLayout = config.var.consoleLayout;
  in {
    console.keyMap = consoleLayout;

    environment.variables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      EDITOR = "nvim"; # Changed from lvim
      TERMINAL = "kitty";
      TERM = "kitty";
      BROWSER = "zen";
    };

    programs.dconf.enable = true;

    services = {
      xserver = {
        enable = true;
        xkb.layout = keyboardLayout;
        xkb.variant = "";
      };
      gnome.gnome-keyring.enable = true;
      dbus = {
        enable = true;
        implementation = "broker";
        packages = with pkgs; [gcr gnome-settings-daemon];
      };
      gvfs.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
      udisks2.enable = true;
      libinput.enable = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = pkgs.stdenv.hostPlatform.isx86_64;
    };

    environment.systemPackages = with pkgs; [
      fd
      bc
      gcc
      file
      git-ignore
      xdg-utils
      wget
      curl
      usbutils
      seahorse
    ];

    security = {
      pam.services = {
        sddm.enableGnomeKeyring = true;
        sddm-password.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
      };
    };
  };
}
