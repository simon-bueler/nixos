{ pkgs, lib, inputs, config, nix-darwin, nixpkgs, ... }:
let
  username = config.var.username;
in {
  imports = [
    ./variables.nix
    ./homebrew.nix
    ../themes/nixy.nix
  ];
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [

  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
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
