{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./cpu.nix
    ./filesystems.nix
    ./networking.nix
    ./nvidia.nix
  ];
}
