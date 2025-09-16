# SDDM is a display manager for X11 and Wayland
{
  pkgs,
  inputs,
  config,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${toString config.stylix.image}";
      HideVirtualKeyboard = true;
    };
  };
in {
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [sddm-astronaut];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Wayland.SessionDir = "${
          inputs.hyprland.packages."${pkgs.system}".hyprland
        }/share/wayland-sessions";
        Theme.EnableAvatars = true;
      };
    };
  };

  environment.systemPackages = [sddm-astronaut];

  # To prevent getting stuck at shutdown
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
