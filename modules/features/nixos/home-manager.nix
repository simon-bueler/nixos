{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs self;};
      users.simon.home.enableNixpkgsReleaseCheck = false;
    };

    environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
  };
}
