# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }:
{

  home = {
    username = "kefrnik";
    homeDirectory = "/home/kefrnik";
  };

  programs.home-manager.enable = true;

  imports = [
    ./desktop-environment/default.nix
    ./development/default.nix
  ];

  home.packages = with pkgs; [
    neofetch
    cowsay
    firefox
    obsidian

    telegram-desktop
    vesktop

    spotify
    kana
    ani-cli

    prismlauncher

    spoof-dpi

    onlyoffice-bin

    alpaca
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
      ExecStart = "${pkgs.spoof-dpi}/bin/spoof-dpi";
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
