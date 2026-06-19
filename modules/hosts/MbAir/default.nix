{
  self,
  inputs,
  ...
}: {
  flake.darwinConfigurations.MbAir = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.nixosModules.MbAirConfiguration
    ];
  };
}
