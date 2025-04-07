{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf (config.specialisation != { }) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages =
      (with pkgs; [
        lshw # sudo lshw -c display    # to check bus id's

        libva-utils
        vdpauinfo
        vulkan-tools
        vulkan-validation-layers
        libvdpau-va-gl
        egl-wayland
        wgpu-utils
        mesa
        libglvnd
        nvtopPackages.full
        nvitop
        libGL

      ])
      ++ (with pkgs; [ vkdevicechooser ]);

    boot.kernelParams = [
      "nvidia_drm.fbdev=1"
    ];

    environment.sessionVariables = {
      GSK_RENDERER = "cairo";
    };

    hardware.nvidia = {
      modesetting.enable = true;
      open = true; # just better
      nvidiaSettings = true;
      forceFullCompositionPipeline = false;

      powerManagement = {
        enable = false; # disable if artefacts
        finegrained = false; # works on turing or newer (should check)
      };

      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        # option A: Offload Mode         // nvidia sleepy - amd worky; amd can ask nvidia for help (nvidia-offload)
        # https://nixos.wiki/wiki/Nvidia
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true;
        # };

        # option B: Sync Mode           // nvidia worky for the most,  but nvidia eats a lot (of energy)
        sync.enable = true;

        # option C: Reverse Sync Mode (experimental)     // amd worky but good external monitors compat i guesss
        #reverseSync.enable = true;
        #allowExternalGpu = false; #// I guess my gpu is very internal

        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
