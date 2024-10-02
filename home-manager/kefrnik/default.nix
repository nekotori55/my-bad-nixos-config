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
    url = "https://w.wallhaven.cc/full/jx/wallhaven-jxlqqw.jpg";
    sha256 = "sha256:05158d9zsqij2asacwjbvxvm2jm6vll3npwvyx8h0c85pl2j9xa7";
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

    spoof-dpi

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
  };

  # Session variables
  home.sessionVariables.EDITOR = "vim";
  home.sessionVariables.FLAKE = "$HOME/.nix-config";

  # Services
  systemd.user.services.spoof-dpi-service = {
    Unit = {
      Description = "Start spoof-dpi";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.spoof-dpi}/bin/spoof-dpi -port 2112";
    };
  };

  # Custom desktop entries
  xdg.desktopEntries = {
    nixos-config = {
      name = "NixOS Config";
      exec = "code /etc/nixos";
      icon = "nix-snowflake";
    };
  };
}
