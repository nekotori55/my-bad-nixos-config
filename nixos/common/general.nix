{ pkgs, ... }:
{
  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    cachix
  ];

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  # Fonts
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      corefonts
      vistafonts
      noto-fonts-cjk-sans
      nerd-fonts.hack
    ];

    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        monospace = [ "Hack Nerd Mono" ];
      };
    };

    enableDefaultPackages = true;

  };

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

  programs.nh.enable = true;
}
