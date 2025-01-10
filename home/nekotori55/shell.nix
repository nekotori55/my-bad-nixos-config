{ pkgs, config,  ...}:
{
  programs = {

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
  };
}