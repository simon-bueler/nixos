{ pkgs, lib, ... }: {
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
      ui_font_size = lib.mkForce 16;
      buffer_font_size = lib.mkForce 16;
      theme = lib.mkForce {
        mode = "dark";
        dark = "One Dark";
        light = "One Light";
      };
      soft_wrap = "editor_width";
      experimental.theme_overrides =  {
        editor.document_highlight.read_background = "#777777FF";
      };
      node = {
        path = "${pkgs.nodejs}/bin/node";
        npm_path = "${pkgs.nodejs}/bin/npm";
      };
      languages = {
        "Nix" = {
            language_servers = [ "nixd" "!nil" ];
    		};
    	};
    };
  };
}
