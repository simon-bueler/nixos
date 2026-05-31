{self, ...}: {
  flake.homeModules.kitty = {
    programs.kitty = {
      enable = true;
      keybindings = {
        "ctrl+alt+tab" = "next_tab";
        "ctrl+alt+shift+tab" = "previous_tab";
        "ctrl+tab" = "send_text all \\x1b[27;5;9~";
        "ctrl+shift+tab" = "send_text all \\x1b[27;6;9~";
        "alt+tab" = "send_text all \\x1b[27;3;9~";
      };
      settings = {
        scrollback_lines = 10000;
        initial_window_width = 1200;
        initial_window_height = 600;
        update_check_interval = 0;
        enable_audio_bell = false;
        confirm_os_window_close = "0";
        remember_window_size = "no";
        disable_ligatures = "never";
        url_style = "curly";
        cursor_shape = "Underline";
        cursor_underline_thickness = 3;
        window_padding_width = 10;
      };
    };
  };
}
