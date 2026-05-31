{self, ...}: {
  flake.nixosModules.openssh = {
    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      allowSFTP = true;
    };
  };
}
