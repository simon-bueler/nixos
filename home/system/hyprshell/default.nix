{inputs, ...}: {
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];
  programs.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
      launcher = {
        enable = false;
        # max_items = 5;
        # plugins.websearch = {
        #   enable = true;
        #   engines = [
        #     {
        #       name = "DuckDuckGo";
        #       url = "https://duckduckgo.com/?q=%s";
        #       key = "d";
        #     }
        #   ];
        # };
      };
      windows.overview.enable = false;
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now hyprshell.service &"
  ];
}
