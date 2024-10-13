# My NixOS configuration
<br>
<div align="center">
    <a href="https://github.com/simon-bueler/nixos/">
        <img src="https://img.shields.io/github/repo-size/anotherhadi/nixy?color={primarycolor}&labelColor={backgroundcolor}&style=for-the-badge&logo=github&logoColor={primarycolor}">
    </a>
    <a href="https://nixos.org">
        <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor={backgroundcolor}&logo=NixOS&logoColor={primarycolor}&color={primarycolor}">
    </a>
    <a href="https://github.com/simon-bueler/nixos/blob/main/LICENSE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA={backgroundcolor}&colorB={primarycolor}&logo=unlicense&logoColor={primarycolor}"/>
    </a>
</div>
<br>

> [!WARNING]
> This is my personal configuration. They may change without notice and can be in a broken state. Use at own risk.

# Installation

1. Start the installer NixOS image
2. Clone this repo into ~/.config
3. run
```sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko .config/nixos/hosts/nixvm/disko-config.nix
```
4. if no error run
```sh
sudo nixos-install --flake .config/nixos#nixvm
```

# 📓 Components (in Progress)
|                             | NixOS + Hyprland                                                                     |
| --------------------------- | :------------------------------------------------------------------------------------:
| **Window Manager**          | [Hyprland][Hyprland] |
| **Bar**                     | [HyprPanel][HyprPanel] |
| **Application Launcher**    | [wofi][wofi] |
| **Notification Daemon**     |  |
| **Terminal Emulator**       | [Kitty][kitty] |
| **Shell**                   | [zsh][zsh] |
| **Text Editor**             | [Zed][zed] + [LunarVim][lunarvim] |
| **network management tool** | [NetworkManager][NetworkManager]  |
| **System resource monitor** | [Btop][Btop] |
| **File Manager**            | [thunar][thunar] + [yazi][yazi] |
| **Fonts**                   |  |
| **Color Scheme**            |  |
| **Cursor**                  |  |
| **Icons**                   |  |
| **Lockscreen**              | [Hyprlock][Hyprlock] |
| **Image Viewer**            | [qview][qview] |
| **Media Player**            | [vlc][vlc] |
| **Music Player**            | [feishin][feishin] |
| **Screenshot Software**     | [swappy][swappy] |
| **Screen Recording**        | [wf-recorder][wf-recorder] |
| **Clipboard**               | [wl-clip-persist][wl-clip-persist] |
| **Color Picker**            | [hyprpicker][hyprpicker] |

# 👥 People

These are the people whom I've taken inspiration or code from while writing these
configs. There surely are more but I tend to forget. Regardless, I am thankful
to all of them.

[anotherhadi](https://github.com/anotherhadi) - [Sascha Koenig](https://www.youtube.com/@m3tam3re) - [fufexan](https://github.com/fufexan) - [elliottminns](https://github.com/elliottminns)
