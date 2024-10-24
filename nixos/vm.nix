{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
  spice-vdagent
  qemu.ga
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
