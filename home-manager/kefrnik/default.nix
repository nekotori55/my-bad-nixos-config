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
    url = "https://w.wallhaven.cc/full/qz/wallhaven-qz8pqd.png";
    sha256 = "sha256:03cfv801yxmpz6kfd5a4cmcxv3xx375bd394295f51ci2zzah6v4";
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
    kana
    ani-cli

    prismlauncher

    spoof-dpi

    onlyoffice-bin

    alpaca

    nekoray

    yandex-disk
  ];

  # Programs
  programs = {
    firefox.enable = true;

    bash = {
      enable = true; # allow homemanager to manage shell

      shellAliases = {
        c = "code /etc/nixos";
        s = "sudo nixos-rebuild switch";
        vm = "mkdir ~/nixos-vm-current; cd ~/nixos-vm-current; rm -rf *; sudo nixos-rebuild build-vm; result/bin/run-$HOSTNAME-vm";

        # Browser bookmarks :skull:
        gh = "firefox --url github.com";
      };
    };

    zathura.enable = true;
  };

  # Session variables
  home.sessionVariables.EDITOR = "vim";

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
