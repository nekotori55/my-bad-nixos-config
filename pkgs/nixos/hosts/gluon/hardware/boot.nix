{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
  };
}
