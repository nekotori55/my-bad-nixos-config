{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/89d297f2-192b-4721-9ebd-fe604709cd5f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/838B-7D5A";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 20 * 1024;
    }
  ];
}
