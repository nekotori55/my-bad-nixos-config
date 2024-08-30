{ pkgs, outputs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./vm-specific.nix
    ./specialisations/on-the-go.nix

    ./general.nix
    ./gaming.nix

    outputs.nixosModules.gnomeMinimal
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.default
    ];
  };

  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };

  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Add swap so no death on cpu-intense tasks
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 20 * 1024;
    }
  ];

  # Network
  networking.hostName = "nixos-xx";

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    hsphfpd.enable = false;
  };

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    wireplumber.extraConfig = {
      "override.monitor.bluez.properties" = {
        "bluez5.enable-msbc" = false;
        "bluez5.hfphsp-backend" = "none";
        "bluez5.a2dp.ldac.quality" = "mq";
        "api.alsa.headroom" = 1024;
        "bluez5.a2dp.aac.bitratemode" = 1;
        "bluez5.roles" = [
          "a2dp_sink"
          "a2dp_source"
        ];
        "10-disable-camera" = {
          "wireplumber.profiles" = {
            main."monitor.libcamera" = "disabled";
          };
        };
      };
    };
  };

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
