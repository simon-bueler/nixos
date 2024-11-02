{
  # https://github.com/anotherhadi/nixy
  description = ''
    Nixy is a NixOS configuration with home-manager, secrets and custom theming all in one place.
    It's a simple way to manage your system configuration and dotfiles.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
          url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
          inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    plugin-markdown = {
      url = "github:MeanderingProgrammer/render-markdown.nvim";
      flake = false;
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    hyprswitch.url = "github:h3rmt/hyprswitch/release";

  };

  outputs = inputs@{ nixpkgs, lix-module, ... }: {
    nixosConfigurations = {
      nixvm = # CHANGEME
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
              _module.args = { inherit inputs; };
            }
            lix-module.nixosModules.default
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            ./hosts/nixvm/configuration.nix # CHANGEME
          ];
        };
      };
      nixSer4 = # CHANGEME
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
              _module.args = { inherit inputs; };
            }
            lix-module.nixosModules.default
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            ./hosts/nixSer4/configuration.nix # CHANGEME
          ];
        };
      };

  };
}
