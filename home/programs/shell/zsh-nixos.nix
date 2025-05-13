{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    initContent = lib.mkBefore ''
      bindkey -e

      ${pkgs.fastfetch + "/bin/fastfetch -l NixOS_small -s OS:Kernel:Packages:Shell:WM:Memory:Disk"}

      zstyle ':fzf-tab:*' fzf-pad 8
    '';

    shellAliases = {
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";

      ssh = "${pkgs.kitty}/bin/kitty +kitten ssh";
      diff = "${pkgs.kitty}/bin/kitty +kitten diff";
    };
  };
}
