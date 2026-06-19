{
  self,
  ...
}: {
  flake.homeModules.imv = {pkgs, ...}: {
    home.packages = [pkgs.imv];
    programs.imv.enable = true;
  };
}
