{pkgs, ...}: {
  home.packages = with pkgs; [streamcontroller];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.streamcontroller}/bin/streamcontroller -b"
  ];
}
