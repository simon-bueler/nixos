{
  self,
  lib,
  ...
}: {
  flake.homeModules.shell = {
    pkgs,
    config,
    osConfig,
    ...
  }: let
    accent = "${osConfig.lib.stylix.colors.base0D}";
    accent2 = "${osConfig.lib.stylix.colors.base0E}";
    background-alt = "${osConfig.lib.stylix.colors.base01}";
    foreground = "#${osConfig.lib.stylix.colors.base05}";
    muted = "#${osConfig.lib.stylix.colors.base03}";
  in {
    gtk.gtk4.theme = null;

    home.packages = with pkgs; [
      bat
      ripgrep
      tldr
      fastfetch
      eza
      fzf
      zoxide
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets" "pattern" "regexp" "root" "line"];
      };
      historySubstringSearch.enable = true;

      history = {
        ignoreDups = true;
        save = 10000;
        size = 10000;
      };

      profileExtra = lib.optionalString (config.home.sessionPath != []) ''
        export PATH="$PATH''${PATH:+:}${
          lib.concatStringsSep ":" config.home.sessionPath
        }"
      '';

      initContent = ''
        bindkey -e
        ${pkgs.fastfetch}/bin/fastfetch -l NixOS_small -s OS:Kernel:Packages:Shell:WM:Memory:Disk
        zstyle ':fzf-tab:*' fzf-pad 8
      '';

      shellAliases = {
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
        wireguard-import = "nmcli connection import type wireguard file";
        open = "${pkgs.xdg-utils}/bin/xdg-open";
        icat = "${pkgs.kitty}/bin/kitty +kitten icat";
        ssh = "${pkgs.kitty}/bin/kitty +kitten ssh";
        diff = "${pkgs.kitty}/bin/kitty +kitten diff";

        # git aliases (system-wide shell)
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
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = lib.concatStrings [
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$character"
        ];
        directory = {style = accent;};
        character = {
          success_symbol = "[❯](${accent})";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](cyan)";
        };
        git_branch = {
          symbol = "[](${background-alt}) ";
          style = "fg:${accent} bg:${background-alt}";
          format = "on [$symbol$branch]($style)[](${background-alt}) ";
        };
        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218)($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "";
          renamed = "";
          deleted = "";
          stashed = "≡";
        };
        git_state = {
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          style = "bright-black";
        };
      };
    };

    programs.zoxide.enable = true;
    programs.eza.enable = true;

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      colors = lib.mkForce {
        "fg+" = "#${accent}";
        "bg+" = "-1";
        "fg" = foreground;
        "bg" = "-1";
        "prompt" = muted;
        "pointer" = "#${accent}";
      };
      defaultOptions = [
        "--margin=1"
        "--layout=reverse"
        "--border=rounded"
        "--info='hidden'"
        "--header=''"
        "--prompt='/ '"
        "-i"
        "--no-bold"
      ];
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      #settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${pkgs.oh-my-posh}/share/oh-my-posh/themes/slimfat.omp.json"));
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext ''
        {
          "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
          "blocks": [
            {
              "alignment": "left",
              "segments": [
                {
                  "background": "#2f2f2f",
                  "foreground": "#${accent}",
                  "leading_diamond": "\ue0c7\u2593",
                  "properties": {
                    "alpine": "\uf300",
                    "arch": "\uf303",
                    "centos": "\uf304",
                    "debian": "\uf306",
                    "elementary": "\uf309",
                    "fedora": "\uf30a",
                    "gentoo": "\uf30d",
                    "linux": "\ue712",
                    "macos": "\ue711",
                    "manjaro": "\uf312",
                    "mint": "\uf30f",
                    "opensuse": "\uf314",
                    "raspbian": "\uf315",
                    "ubuntu": "\uf31c",
                    "windows": "\ue70f"
                  },
                  "style": "diamond",
                  "template": " {{ if .WSL }}\ue712 on {{ end }}{{ .Icon }}<#7a7a7a> \ue0b1</>",
                  "type": "os"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#fafafa",
                  "style": "diamond",
                  "template": " {{ if ne .Env.POSH_SESSION_DEFAULT_USER .UserName }}<#${accent}>{{ .UserName }}</><#7a7a7a>\uf1fa</>{{ end }}<#${accent2}>{{ .HostName }}</><#7a7a7a> \ue0b1</>",
                  "type": "session"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#${accent2}",
                  "style": "diamond",
                  "template": " \uf0e7<#7a7a7a> \ue0b1</>",
                  "type": "root"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#fafafa",
                  "properties": {
                    "folder_icon": "<#B5B2C2>\ue5fe </>",
                    "style": "full"
                  },
                  "style": "diamond",
                  "template": "<#a9a900> \ue5ff </>{{ .Path }} ",
                  "type": "path"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#${accent}",
                  "foreground_templates": [
                    "{{ if or (.Working.Changed) (.Staging.Changed) }}#${accent}{{ end }}",
                    "{{ if gt .Ahead 0 }}#2EC4B6{{ end }}",
                    "{{ if gt .Behind 0 }}#8A4FFF{{ end }}"
                  ],
                  "properties": {
                    "fetch_stash_count": true,
                    "fetch_status": true,
                    "fetch_upstream_icon": true
                  },
                  "style": "diamond",
                  "template": "<#7a7a7a>\ue0b1 </>{{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}<#E84855> \uf044 {{ .Working.String }}</>{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#2FDA4E> \uf046 {{ .Staging.String }}</>{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                  "type": "git"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#fafafa",
                  "style": "diamond",
                  "trailing_diamond": "\ue0b0",
                  "type": "text"
                }
              ],
              "type": "prompt"
            },
            {
              "alignment": "right",
              "segments": [
                {
                  "background": "#2f2f2f",
                  "foreground": "#fafafa",
                  "leading_diamond": "\ue0b2",
                  "style": "diamond",
                  "type": "text"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#6CA35E",
                  "style": "diamond",
                  "template": " \ue718 {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }}<#7a7a7a> \ue0b3</>",
                  "type": "node"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#96E072",
                  "style": "diamond",
                  "template": " \ue235 {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}<#7a7a7a> \ue0b3</>",
                  "type": "python"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#3891A6",
                  "style": "diamond",
                  "template": " \ue77f {{ if .Unsupported }}\uf071{{ else }}{{ .Full }}{{ end }}<#7a7a7a> \ue0b3</>",
                  "type": "dotnet"
                },
                {
                  "background": "#2f2f2f",
                  "foreground": "#fafafa",
                  "properties": {
                    "time_format": "15:04:05"
                  },
                  "style": "diamond",
                  "template": " {{ .CurrentDate | date .Format }}<#${accent2}> \ue641 </>",
                  "trailing_diamond": "\u2593\ue0c6",
                  "type": "time"
                }
              ],
              "type": "prompt"
            },
            {
              "alignment": "left",
              "newline": true,
              "segments": [
                {
                  "foreground": "#7a7a7a",
                  "style": "plain",
                  "template": " ~#@\u276f ",
                  "type": "text"
                }
              ],
              "type": "prompt"
            },
            {
              "alignment": "right",
              "segments": [
                {
                  "foreground": "#7a7a7a",
                  "style": "plain",
                  "template": " \u276e ",
                  "type": "text"
                },
                {
                  "foreground": "#FFCE5C",
                  "properties": {
                    "style": "roundrock",
                    "threshold": 500
                  },
                  "style": "plain",
                  "template": " {{ .FormattedMs }}<#fafafa> \uf252 </>",
                  "type": "executiontime"
                },
                {
                  "foreground": "#9FD356",
                  "foreground_templates": [
                    "{{ if gt .Code 0 }}#E84855{{ end }}"
                  ],
                  "properties": {
                    "always_enabled": true
                  },
                  "style": "plain",
                  "template": " \uea9f {{ if gt .Code 0 }}{{ .Code }}{{ end }} ",
                  "type": "status"
                }
              ],
              "type": "rprompt"
            }
          ],
          "console_title_template": "{{if .Root}}root :: {{end}}{{.Shell}} :: {{.Folder}}",
          "final_space": true,
          "transient_prompt": {
            "background": "transparent",
            "foreground": "#7a7a7a",
            "template": " ~#@\u276f "
          },
          "version": 2
        }
      '');
    };
  };
}
