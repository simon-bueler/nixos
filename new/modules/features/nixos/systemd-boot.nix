{self, ...}: {
  flake.nixosModules.systemd-boot = {
    pkgs,
    lib,
    ...
  }: {
    boot = {
      bootspec.enable = true;
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          consoleMode = "auto";
          configurationLimit = 8;
        };
      };
      supportedFilesystems = ["ntfs"];
      tmp.cleanOnBoot = true;
      kernelPackages = pkgs.linuxPackages_latest;

      # Silent boot
      kernelParams = [
        "quiet"
        "usbcore.autosuspend=-1"
        "usbcore.old_scheme_first=1"
        "iommu=pt"
        "usbcore.initial_descriptor_timeout=30"
        "usbhid.quirks=0x0b05:0x1a85:0x0040"
        "usbhid.initial_delay=2"
        "pcie_aspm=off"
        "vga=current"

        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "boot.shell_on_fail"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;

      plymouth = {
        enable = false;
        theme = lib.mkForce "tech_b";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["tech_b"];
          })
        ];
      };
    };
  };
}
