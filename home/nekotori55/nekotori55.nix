{ pkgs, osConfig, ... }:
{
  home = {
    username = "nekotori55";
    homeDirectory = "/home/nekotori55";
  };

  # Wallpaper
  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/g7/wallhaven-g796we.jpg";
    sha256 = "sha256:0d8kvymakvnvyxavwc5dj9g11gqpzvmyaipvkcyf5ayqd28p7cc3";
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

  home.packages =
    with pkgs;
    [
      # Browser
      vivaldi

      # Messagers
      telegram-desktop

      # Docs
      obsidian

      alacritty-theme
    ]
    ++ lib.optionals (osConfig.usrEnv.personal) [
      # Other software
      alpaca
      vesktop

      # Learning
      kana
      klavaro
      anki-bin

      # Entertainment
      spotify
      ani-cli
      prismlauncher
    ];

  fonts.fontconfig.enable = true;

  # Programs
  programs = {
    git = {
      enable = true;
      userName = "Nekotori";
      userEmail = "nekotori55@gmail.com";

      includes = [
        {
          condition = "gitdir:~/work/";
          path = "~/work/.gitconfig";
        }
      ];
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
