{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./variables.nix
    ../../home/programs/shell
    ../../home/programs/shell/zsh-darwin.nix
    ../../home/programs/wezterm
    ../../home/programs/zed-editor
  ];
  home = {
    inherit (config.var) username;
    homeDirectory = "/Users/" + config.var.username;

    packages = with pkgs; [
      # Dev
      nil
      alejandra
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
