{
  # https://github.com/anotherhadi/nixy
  description = ''
    Nixy is a NixOS configuration with home-manager, secrets and custom theming all in one place.
    It's a simple way to manage your system configuration and dotfiles.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprshell = {
      url = "github:H3rmt/hyprshell?ref=hyprshell-release";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###For Raspberry Pi
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ### Darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Make installed Packages available for search
    mac-app-util.url = "github:hraban/mac-app-util";
    #Homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    hyprshell,
    nvf,
    ...
  }: {
    nixosConfigurations = {
      nixvm = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nixpkgs.overlays = [inputs.hyprpanel.overlay];
            _module.args = {inherit inputs;};
          }
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./hosts/nixvm/configuration.nix # CHANGEME
        ];
      };
      nixSer4 = nixpkgs.lib.nixosSystem {
        modules = [
          {
            _module.args = {inherit inputs;};
          }
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./hosts/nixSer4/configuration.nix
        ];
      };
      #build config locally
      nixpi = nixpkgs.lib.nixosSystem {
        modules = [
          {
            _module.args = {inherit inputs;};
          }
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          ./hosts/nixpi/configuration.nix
        ];
      };
    };
    darwinConfigurations."mbair" = nix-darwin.lib.darwinSystem {
      modules = [
        inputs.mac-app-util.darwinModules.default
        inputs.stylix.darwinModules.stylix
        ./hosts/MbAir/configuration.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ];
      specialArgs = {inherit inputs;};
    };
  };
}
