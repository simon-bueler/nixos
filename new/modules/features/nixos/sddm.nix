{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sddm = {
    pkgs,
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
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri
          }/share/wayland-sessions";
          Theme.EnableAvatars = true;
        };
      };
    };

    environment.systemPackages = [sddm-astronaut];

    systemd.services.display-manager = {
      after = ["systemd-udev-settle.service"];
      wants = ["systemd-udev-settle.service"];
    };

    # To prevent getting stuck at shutdown
    systemd.settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };
  };
}
