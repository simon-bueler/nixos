{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    initContent = lib.mkBefore ''
      bindkey -e

      ${pkgs.fastfetch + "/bin/fastfetch -l macos_small -s OS:Kernel:Packages:Shell:WM:Memory:Disk"}

      zstyle ':fzf-tab:*' fzf-pad 8
    '';
  };
}
