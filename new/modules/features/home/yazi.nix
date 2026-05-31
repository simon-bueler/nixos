{self, ...}: {
  flake.homeModules.yazi = {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y";
      settings = {
        log = {enabled = false;};
        manager = {
          show_hidden = true;
          sort_by = "alphabetical";
          sort_dir_first = true;
          sort_reverse = false;
        };
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
  };
}
