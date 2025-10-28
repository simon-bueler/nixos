{
  pkgs,
  config,
  ...
}: let
  hostname = config.var.hostname;
  keyboardLayout = config.var.keyboardLayout;
  consoleLayout = config.var.consoleLayout;
in {
  networking.hostName = hostname;

  console.keyMap = consoleLayout;

  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "lvim";
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
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
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
  # Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
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
    seahorse
  ];

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
  };

  security = {
    pam.services = {
      # allow wayland lockers to unlock the screen
      hyprlock.text = "auth include login";

      # userland niceness
      rtkit.enable = true;

      # unlock keyring on login
      sddm.enableGnomeKeyring = true;
      sddm-password.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
  };
}
