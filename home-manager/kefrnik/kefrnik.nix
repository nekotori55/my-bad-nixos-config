{ pkgs, config, ... }:
{
  home = {
    username = "kefrnik";
    homeDirectory = "/home/kefrnik";
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

    bash = {
      enable = true; # allow homemanager to manage shell

      shellAliases = {
        sconfig = "code /etc/nixos";
        vm = "mkdir ~/nixos-vm-current; cd ~/nixos-vm-current; rm -rf *; sudo nixos-rebuild build-vm; result/bin/run-$HOSTNAME-vm";
      };

      bashrcExtra = ''
              if [ -x "$(command -v tmux)" ] && [ -n "''${DISPLAY}" ] && [ -z "''${TMUX}" ]; then
            # exec tmux new-session -A -s ''${USER} >/dev/null 2>&1
            exec tmux new-session >/dev/null 2>&1
        fi
      '';
    };

    fish = {
      enable = true;
      shellAliases = config.programs.bash.shellAliases;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    alacritty = {
      enable = true;
      settings = {
        general.import = [ "${pkgs.alacritty-theme}/nord.toml" ];
        font = {
          normal = {
            family = "Hack Nerd Font Mono";
            style = "Regular";

          };
        };

        window = {
          padding = {
            x = 10;
            y = 0;
          };
          dynamic_padding = true;
          decorations = "None";
        };

        # env.term = "xterm-256color";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    tmux = {
      enable = true;
      shortcut = "a";
      # aggressiveResize = true; -- Disabled to be iTerm-friendly
      baseIndex = 1;
      newSession = true;
      escapeTime = 50;
      clock24 = true;
      # terminal = "xterm-256color";
      shell = "${pkgs.fish}/bin/fish";

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
      ];

      extraConfig = ''
        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/

        # Mouse works as expected
        set-option -g mouse on
        # easy-to-remember split pane commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
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
