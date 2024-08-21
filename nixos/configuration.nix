# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
    ./desktop-environments/default.nix
    ./nvidia.nix
    ./vm.nix
    ./on-the-go-specialisation.nix
  ];


  # NIXOS CFG
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than +15";
  };

  # HARDWARE CFG
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
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 20 * 1024;
  }];

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
      };
    };
    #wireplumber.settings = {bluetooth.autoswitch-to-headset-profile = false;};
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


  # SYSTEM CFG
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    cachix
  ];


  # Everything after this point is kinda user settings but 
  # were stated here out of necessity
  users.users = {
    kefrnik = {
      initialPassword = "aboba";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" ];
    };
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    corefonts
    vistafonts
  ];
  fonts.enableDefaultPackages = true;

  # Enable docker (rootless mode)
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];


  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  programs.gamemode.enable = true;
  #programs.steam.enable = true; # Couldn't install through home-manager lol cuz need some system stuff

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraLibraries = (pkgs:
        with pkgs;[
          openssl
          nghttp2
          libidn2
          rtmpdump
          libpsl
          curl
          krb5
          keyutils
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
        ]);
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
