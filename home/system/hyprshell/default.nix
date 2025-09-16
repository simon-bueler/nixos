{inputs, ...}: {
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];
  programs.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
      windows.enable = false;
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now hyprshell.service &"
  ];
}
