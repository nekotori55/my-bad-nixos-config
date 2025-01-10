{ pkgs, config, ... }:
{
  home = {
    username = "nekotori55";
    homeDirectory = "/home/nekotori55";
  };

  # Modules switchers
  development.enable = true;

  # Wallpaper
  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/kx/wallhaven-kxor61.jpg";
    sha256 = "sha256:1ps0zr288nrjx427a62941lgxgzagz1x1xpcn5f7sq84h22cpshc";
  };

  # Session variables
  home.sessionVariables = {
    EDITOR = "vim";
    FLAKE = "$HOME/.nixos-config";
  };

  # Allows nix-shell to download unfree packages
  home.file.".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    # Funny stuff
    neofetch
    cowsay

    # Browser
    vivaldi

    # Messagers
    telegram-desktop
    vesktop

    # Docs
    obsidian
    onlyoffice-bin
    pandoc

    # Entertainment
    spotify
    ani-cli
    prismlauncher

    # Learning
    kana
    klavaro
    anki-bin

    # Other software
    alpaca
    nekoray
    yandex-disk
    alacritty-theme
  ];

  fonts.fontconfig.enable = true;

  # Programs
  programs = {
    git = {
      enable = true;
      userName = "Nekotori";
      userEmail = "nekotori55@gmail.com";
    };

    zathura.enable = true;
    zathura.extraConfig = ''
      set selection-clipboard clipboard
    '';
  };

  # Custom desktop entries
  xdg.desktopEntries = {
    nixos-config = {
      name = "NixOS Config";
      exec = "code /etc/nixos";
      icon = "nix-snowflake";
    };
  };

  home.stateVersion = "23.05";
}
