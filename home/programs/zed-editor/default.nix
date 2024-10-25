{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];

    userSettings =
    {
      features = {
        copilot = false;
      };
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        dark = "One Dark";
      };
      soft_wrap = "editor_width";
    };
  };
}
