{ lib, ... }:
{
  specialisation = {
    on-the-go.configuration = {
      services.ollama.acceleration = false;
      
      system.nixos.tags = [ "on-the-go" ];
      hardware = {
        nvidia = {
          prime.offload.enable = lib.mkForce true;
          prime.offload.enableOffloadCmd = lib.mkForce true;
          prime.sync.enable = lib.mkForce false;

          powerManagement.enable = lib.mkForce true; # disable if artefacts
          powerManagement.finegrained = lib.mkForce true; # works on turing or newer (should check)
        };

        bluetooth.powerOnBoot = lib.mkForce false;
      };
    };
  };
}
