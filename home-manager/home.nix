# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs
, ...
}: {

  home = {
    username = "kefrnik";
    homeDirectory = "/home/kefrnik";
  };

  programs.home-manager.enable = true;

  imports = [
    ./dev.nix
    ./gnome.nix
  ];


  home.packages = with pkgs; [
    neofetch
    cowsay
    firefox

    telegram-desktop
    vesktop

    spotify

    prismlauncher

    spoof-dpi

    obsidian
  ];

  # Programs
  programs.firefox.enable = true;

  # Variables (doesn't work)
  home.sessionVariables.NIXOS_OZONE_WL = "1";
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
