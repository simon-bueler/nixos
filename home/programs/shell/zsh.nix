{ pkgs, lib, config, ... }:
{

  home.packages = with pkgs; [ bat ripgrep tldr sesh fastfetch ];

  home.sessionPath = [ "$HOME/go/bin" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    initExtraFirst = ''
      bindkey -e

      ${pkgs.fastfetch + "/bin/fastfetch -l NixOS_small -s OS:Kernel:Packages:Shell:WM:Memory:Disk"}

      function sesh-sessions() {
        session=$(sesh list -t -c | fzf --height 70% --reverse)
        [[ -z "$session" ]] && return
        sesh connect $session
      }

      zle     -N             sesh-sessions
      bindkey -M emacs '\es' sesh-sessions
      bindkey -M vicmd '\es' sesh-sessions
      bindkey -M viins '\es' sesh-sessions

      zstyle ':fzf-tab:*' fzf-pad 8
    '';

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
      export PATH="$PATH''${PATH:+:}${
        lib.concatStringsSep ":" config.home.sessionPath
      }"
    '';

    shellAliases = {
      nvim = "lvim";
      vim = "lvim";
      vi = "lvim";
      v = "lvim";
      c = "clear";
      clera = "clear";
      celar = "clear";
      e = "exit";
      cd = "z";
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";
      la = "ls -al";
      sl = "ls";
      cat = "bat";
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";

      ssh = "${pkgs.kitty}/bin/kitty +kitten ssh";
      diff = "${pkgs.kitty}/bin/kitty +kitten diff";

      wireguard-import = "nmcli connection import type wireguard file";


      # git
      ga = "git add";
      gc = "git commit";
      gcm = "git commit -m";
      gcu = "git add . && git commit -m 'Update'";
      gp = "git push";
      gpl = "git pull";
      gs = "git status";
      gd = "git diff";
      gco = "git checkout";
      gcb = "git checkout -b";
      gbr = "git branch";
    };
    plugins = [
        {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        file = "share/zsh-completions/zsh-completions.zsh";
        }
        {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
    ];
  };
}
