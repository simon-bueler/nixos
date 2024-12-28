{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      log = { enabled = false; };
      manager = {
        show_hidden = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
        sort_reverse = false;
      };
      # opener = {
      #   play = [
      #     {
      #       run = "vlc \"$@\"";
      #     }
      #   ];
      # };
      open = {
        prepend_rules = [
          {
           name = "*.m3u8";
           use = "play";
          }
        ];
      };
    };
  };
}
