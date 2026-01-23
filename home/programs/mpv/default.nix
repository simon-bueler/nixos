{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv.override {
        mpv-unwrapped = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );

    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
    };
    bindings = {
      "Shift+S" = "playlist-shuffle";
    };

    scripts = with pkgs.mpvScripts; [
      uosc
      sponsorblock
    ];
  };
}
