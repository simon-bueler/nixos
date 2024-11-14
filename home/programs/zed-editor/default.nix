{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];

    userSettings =
    {
      features = {
        copilot = false;
      };
      assistant = {
         default_model = {
           provider = "zed.dev";
           model = "claude-3-5-sonnet-latest";
         };
         version = "2";
      };
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        dark = "One Dark";
      };
      soft_wrap = "editor_width";
      experimental.theme_overrides =  {
        editor.document_highlight.read_background = "#777777FF";
      };
      node = {
        path = "${pkgs.nodejs}/bin/node";
        npm_path = "${pkgs.nodejs}/bin/npm";
      };
    };
  };
}
