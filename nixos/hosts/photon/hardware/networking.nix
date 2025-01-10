{ lib, ... }:
{
  networking.hostName = "photon";
  networking.useDHCP = lib.mkDefault true;

  # REQUIRED FOR NEKORAY TUN MODE TO WORK!!
  services.resolved.enable = true;
}
