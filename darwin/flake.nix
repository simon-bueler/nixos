{
  description = "MacOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:{
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbair" = nix-darwin.lib.darwinSystem {
      modules = [
        inputs.mac-app-util.darwinModules.default
        inputs.stylix.darwinModules.stylix
          ./configuration.nix
        inputs.home-manager.darwinModules.home-manager
];
      specialArgs = { inherit inputs; };
    };
  };
}
