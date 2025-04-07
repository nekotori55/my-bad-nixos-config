{ lib, ... }:
{
  specialisation = {
    on-the-go.configuration = {
      environment.etc."specialisation".text = "on-the-go";

      services.ollama.acceleration = lib.mkForce false;

      # do not autostart docker containers on boot
      virtualisation.docker.enableOnBoot = lib.mkForce false;

      system.nixos.tags = [ "on-the-go" ];
      hardware = {
        # nvidia = {
        #   prime.offload.enable = lib.mkForce true;
        #   prime.offload.enableOffloadCmd = lib.mkForce true;
        #   prime.sync.enable = lib.mkForce false;

        #   powerManagement.enable = lib.mkForce true; # disable if artefacts
        #   powerManagement.finegrained = lib.mkForce true; # works on turing or newer (should check)
        # };

        # bluetooth.powerOnBoot = lib.mkForce false;
      };

      powerManagement.scsiLinkPolicy = "medium_power";
      powerManagement.cpuFreqGovernor = "powersave";
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;

      # disable nvidia 

      boot.extraModprobeConfig = lib.mkDefault ''
        blacklist nouveau
        options nouveau modeset=0
      '';

      services.udev.extraRules = lib.mkDefault ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
      boot.blacklistedKernelModules = lib.mkDefault [
        "nouveau"
        "nvidia"
      ];
    };
  };
}
