{...}: {
  services.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
      windows.enable = false;
    };
  };
}
