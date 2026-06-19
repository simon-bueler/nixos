{
  self,
  ...
}: {
  flake.nixosModules.rog-azoth-reset = {pkgs, ...}: {
    systemd.services.rog-azoth-reset = {
      description = "Reset ROG Azoth USB dongle to fix boot hang";
      wantedBy = ["multi-user.target"];
      before = ["display-manager.service"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        sleep 5
        DEV_INFO=$(${pkgs.usbutils}/bin/lsusb -d 0b05:1a85)
        BUS=$(echo "$DEV_INFO" | ${pkgs.gawk}/bin/awk '{print $2}')
        DEV=$(echo "$DEV_INFO" | ${pkgs.gawk}/bin/awk '{print $4}' | ${pkgs.gnused}/bin/sed 's/://')
        DEV_PATH="/dev/bus/usb/$BUS/$DEV"

        if [ -n "$DEV_PATH" ] && [ -e "$DEV_PATH" ]; then
          echo "Found ROG Azoth at $DEV_PATH. Performing hardware reset..."
          ${pkgs.usbutils}/bin/usbreset "$DEV_PATH" || true
        fi
      '';
    };
  };
}
