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

  # Modules switchers
  gnomeConfigs.enable = true;
  development.enable = true;

  # Wallpaper
  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/m3/wallhaven-m37z18.png";
    sha256 = "sha256:1yp3s9p95qs5zisqg1p4q6lwlgvl5cnm71dd8g9bbyb8nn9fv8wy";
  };

  # Session variables
  home.sessionVariables = {
    EDITOR = "vim";
    FLAKE = "$HOME/.nix-config";
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
    git = {
      enable = true;
      userName = "Nekotori";
      userEmail = "nekotori55@gmail.com";
    };

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
