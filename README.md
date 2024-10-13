run installer nixos-image

clone to ~/.config/nixos

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko .config/nixos/hosts/nixvm/disko-config.nix

sudo nixos-install --flake .config/nixos#nixvm

# 📓 Components
|                             | NixOS + Hyprland                                                                              |
| --------------------------- | :---------------------------------------------------------------------------------------------:
| **Window Manager**          | [Hyprland][Hyprland] |
| **Bar**                     | [HyprPanel][HyprPanel] |
| **Application Launcher**    | [rofi][rofi] |
| **Notification Daemon**     | [swaync][swaync] |
| **Terminal Emulator**       | [Wezterm][Wezterm] |
| **Shell**                   | [zsh][zsh] |
| **Text Editor**             | [VSCodium][VSCodium] + [Neovim][Neovim] |
| **network management tool** | [NetworkManager][NetworkManager] + [network-manager-applet][network-manager-applet] |
| **System resource monitor** | [Btop][Btop] |
| **File Manager**            | [nemo][nemo] + [yazi][yazi] |
| **Fonts**                   | [CascadiaCode Nerd Font][Nerd fonts] + [JetBrainsMono Nerd Font][Nerd fonts] |
| **Color Scheme**            | [Gruvbox Dark Hard][Gruvbox] |
| **Cursor**                  | [Bibata-Modern-Ice][Bibata-Modern-Ice] |
| **Icons**                   | [Papirus-Dark][Papirus-Dark] |
| **Lockscreen**              | [Hyprlock][Hyprlock] + [Swaylock-effects][Swaylock-effects] |
| **Image Viewer**            | [qview][qview] |
| **Media Player**            | [mpv][mpv] |
| **Music Player**            | [audacious][audacious] |
| **Screenshot Software**     | [grimblast][grimblast] |
| **Screen Recording**        | [wf-recorder][wf-recorder] |
| **Clipboard**               | [wl-clip-persist][wl-clip-persist] |
| **Color Picker**            | [hyprpicker][hyprpicker] |

# 👥 People

These are the people whom I've taken inspiration or code from while writing these
configs. There surely are more but I tend to forget. Regardless, I am thankful
to all of them.

[anotherhadi](https://github.com/anotherhadi) - [Sascha Koenig](https://www.youtube.com/@m3tam3re) - [fufexan](https://github.com/fufexan) - [elliottminns](https://github.com/elliottminns)
