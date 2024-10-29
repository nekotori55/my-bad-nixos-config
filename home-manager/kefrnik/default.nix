{ pkgs, ... }:
{
  home = {
    username = "kefrnik";
    homeDirectory = "/home/kefrnik";
  };

  imports = [
    ./desktop-environment/default.nix
    ./development/default.nix
  ];

  gnomeConfigs.enable = true;
  development.enable = true;

  # Wallpaper
  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/9d/wallhaven-9d161x.png";
    sha256 = "sha256:0h25lg2hg0wnmc85s43rfqlayfghl38kkkiq3xbydr54n5yhvd5d";
  };

  programs.git = {
    enable = true;
    userName = "Nekotori";
    userEmail = "nekotori55@gmail.com";
  };

  home.packages = with pkgs; [
    # Funny stuff
    neofetch
    cowsay

    # Browser
    vivaldi

    # Messagers
    telegram-desktop
    vesktop
    discord

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

    # Other software
    alpaca
    nekoray
    yandex-disk
  ];

  # Programs
  programs = {
    bash = {
      enable = true; # allow homemanager to manage shell

      shellAliases = {
        config = "code /etc/nixos";
        switch = "nh os switch";
        test = "nh os test";
        clean = "nh clean all";
        search = "nh search";
        vm = "mkdir ~/nixos-vm-current; cd ~/nixos-vm-current; rm -rf *; sudo nixos-rebuild build-vm; result/bin/run-$HOSTNAME-vm";
      };
    };

    zathura.enable = true;
    zathura.extraConfig = ''
      set selection-clipboard clipboard
    '';
  };

  # Session variables
  home.sessionVariables.EDITOR = "vim";
  home.sessionVariables.FLAKE = "$HOME/.nix-config";

  # Custom desktop entries
  xdg.desktopEntries = {
    nixos-config = {
      name = "NixOS Config";
      exec = "code /etc/nixos";
      icon = "nix-snowflake";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
