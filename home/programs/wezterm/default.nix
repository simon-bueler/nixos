{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      config = wezterm.config_builder()

      config = {
          automatically_reload_config = true,
          window_decorations = "RESIZE",
          use_fancy_tab_bar = false,
      }

      return config
    '';
  };
}
