{ outputs, ... }:
{
  imports = [
    outputs.nixosModules.gnomeMinimal

    ../../common
  ];

  vm-manager.enable = true;
  ai.enable = true;
  docker.enable = true;
  gaming.enable = true;
}
