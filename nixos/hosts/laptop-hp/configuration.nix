{ pkgs, outputs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../vm/vm-specific.nix
    ./specialisations/on-the-go.nix
    ./module-settings.nix
  ];

  users.users = {
    kefrnik = {
      initialPassword = "aboba";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" ];
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
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
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_GB.UTF-8";
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

    extraConfig.pipewire = {
      context.properties = {
        default.clock.rate = 48000;
        #defautlt.allowed-rates = [ 192000 48000 44100 ];
        defautlt.allowed-rates = [ 48000 ];
        default.clock.quantum = 2048;
        default.clock.min-quantum = 1024;
        #default.clock.max-quantum = 32;
      };
    };

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

  boot.supportedFilesystems = {
    ntfs = true;
  };

  # REQUIRED FOR NEKORAY TUN MODE TO WORK!!
  services.resolved.enable = true;

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        action.id == "org.freedesktop.policykit.exec" &&
        (action.lookup("command_line").indexOf(' /home/' + subject.user + '/.config/nekoray/config/vpn-run-root.sh') !== -1)
        )
      {
        return polkit.Result.YES;
      }
    });
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
