{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nixSer4Configuration = {
    pkgs,
    lib,
    ...
  }: {
    # import any other modules from here
    imports = [
      self.nixosModules.nixSer4Hardware

      # disko
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.nixSer4
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # environment.systemPackages = with pkgs; [
    #   (callPackage ../../nixos/hyprland-alt-tab.nix {})
    # ];
    # Syncthing ports: 8384 for remote access to GUI
    # 22000 TCP and/or UDP for sync traffic
    # 21027/UDP for discovery
    # source: https://docs.syncthing.net/users/firewall.html
    networking.firewall.allowedTCPPorts = [22000];
    networking.firewall.allowedUDPPorts = [22000 21027];

    virtualisation.podman.enable = true;

    #Printing
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Don't touch this
    system.stateVersion = "24.05";
  };
}
