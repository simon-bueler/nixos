{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixSer4 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixSer4Configuration
    ];
  };
}
