{ config, pkgs-unstable, ... }:
{
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs-unstable.pkgsi686Linux; [ libva ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs-unstable; [
    lshw #  sudo lshw -c display    # to check bus id's

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

    vkdevicechooser
  ];

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  #hardware.graphics = {
  #  enable = true;
  #  extraPackages = [
  #    config.boot.kernelPackages.nvidiaPackages.production
  #  ];
  #};

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # just better
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;

    powerManagement = {
      enable = false; # disable if artefacts
      finegrained = false; # works on turing or newer (should check)
    };

    #package = config.boot.kernelPackages.nvidiaPackages.production;

    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.58.02";
      sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
      openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
      settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
    };


    prime = {
      # option A: Offload Mode         // nvidia sleepy - amd worky; amd can ask nvidia for help (nvidia-offload)
      # https://nixos.wiki/wiki/Nvidia
      # offload = {
      #   #  enable = true;
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
}
