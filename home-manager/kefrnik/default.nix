{ pkgs, ... }:
{
  home = {
    username = "kefrnik";
    homeDirectory = "/home/kefrnik";
  };

  imports = [
    ../common
  ];

  # Wallpaper
  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/zy/wallhaven-zyj8gw.jpg";
    sha256 = "sha256:1q5jkc9jrvlln59vdvqy17dzl9x4c72bxw924fvgl6dh8fagv5jq";
  };

  programs.git = {
    enable = true;
    userName = "Nekotori";
    userEmail = "nekotori55@gmail.com";
  };

  gnomeConfigs.enable = true;
  development.enable = true;

  home.packages = with pkgs; [
    neofetch
    cowsay
    firefox
    obsidian

    telegram-desktop
    vesktop
    discord

    spotify
    ani-cli

    prismlauncher

    onlyoffice-bin

    alpaca

    nekoray

    yandex-disk

    kana
    klavaro

    pandoc
  ];

  # Programs
  programs = {
    firefox.enable = true;

    bash = {
      enable = true; # allow homemanager to manage shell

      shellAliases = {
        config = "code /etc/nixos";
        switch = "nh os switch";
        test = "nh os test";
        clean = "nh clean all";
        search = "nh search";
        vm = "mkdir ~/nixos-vm-current; cd ~/nixos-vm-current; rm -rf *; sudo nixos-rebuild build-vm; result/bin/run-$HOSTNAME-vm";
        # Browser bookmarks :skull:
        gh = "firefox --url github.com";
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
}
