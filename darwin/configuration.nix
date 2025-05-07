{ pkgs, lib, inputs, config, nix-darwin, nixpkgs, ... }:
let
  username = config.var.username;
in {
  imports = [
    ./variables.nix

    ../themes/nixy.nix
  ];
  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [
    mkalias
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

  # Create Mac Alias aka findable System entries
  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
    # Set up applications.
    echo "setting up /Applications..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
    done
        '';

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager.users."${config.var.username}" = import ./home.nix;
  # To enable it for all users:
  home-manager.sharedModules = [
    inputs.mac-app-util.homeManagerModules.default
  ];
}
