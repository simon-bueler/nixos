{
  self,
  ...
}: {
  flake.homeModules.udiskie = {
    services.udiskie = {
      enable = true;
      notify = true;
      automount = true;
    };
  };
}
