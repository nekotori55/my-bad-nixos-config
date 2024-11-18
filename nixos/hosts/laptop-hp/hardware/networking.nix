{ lib, ... }:
{
  networking.hostName = "nixos-xx";
  networking.useDHCP = lib.mkDefault true;

  # REQUIRED FOR NEKORAY TUN MODE TO WORK!!
  services.resolved.enable = true;
}
