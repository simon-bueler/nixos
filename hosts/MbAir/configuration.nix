{
  pkgs,
  inputs,
  config,
  ...
}: let
  username = config.var.username;
in {
  imports = [
    ./variables.nix
    ../../darwin/homebrew.nix
    ../../darwin/mac.nix
    ../../darwin/aerospace.nix
    ../../themes/nixy.nix
  ];
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  system.primaryUser = "${username}";

  environment.systemPackages = with pkgs; [
    zed-editor
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable ctrlernative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = "${username}";
  };

  home-manager.users."${config.var.username}" = import ./home.nix;
  # To enable it for all users:
  home-manager.sharedModules = [
    inputs.mac-app-util.homeManagerModules.default
  ];
}
