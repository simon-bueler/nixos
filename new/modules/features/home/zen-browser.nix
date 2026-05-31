{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zen-browser = {config, ...}: {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        AutofillAddressesEnabled = false;
        AutoFillCreditCardEnabled = false;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DontCheckDefaultBrowser = true;
        NewTabPage = true;
      };
      profiles."default" = {};
    };
    stylix.targets.zen-browser.profileNames = ["default"];
  };
}
