{
  pkgs,
  config,
  lib,
  outputs,
  osConfig,
  ...
}:
{
  imports = [
    outputs.homeManagerModules.gnomeKeybindings
  ];

  # If gnome is enabled on the system
  config = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {

    programs.gnome-shell = {
      # Enable gnome customisation using home-manager
      enable = true;

      extensions =
        let
          extensions = pkgs.gnomeExtensions;
        in
        [
          { package = extensions.appindicator; }
          { package = extensions.pop-shell; }
          { package = extensions.gravatar; }
          { package = extensions.user-avatar-in-quick-settings; }
          { package = extensions.blur-my-shell; }
        ];

      theme = {
        name = "Nordic-bluish-accent";
        package = pkgs.nordic;
      };

      # Create custom keybindings
      custom-keybindings = {
        browser = {
          binding = "<Super>w";
          command = "vivaldi";
        };

        terminal = {
          binding = "<Super>t";
          command = "kgx";
        };

        explorer = {
          binding = "<Super>e";
          command = "nautilus";
        };

        explorer-admin = {
          binding = "<Shift><Super>e";
          command = "nautilus admin:/";
        };

        nixos-config = {
          binding = "<Super>c";
          command = "code /etc/nixos/";
        };

      };
    };

    # Other settings
    dconf = {
      enable = true;

      settings = {
        "org/gnome/desktop/background" =
          let
            username = config.home.username;
            bg = "file:///home/${username}/.wallpaper.png";
          in
          {
            picture-uri = "${bg}";
            picture-uri-dark = "${bg}";
          };

        # set time before gnome shows "app is not responding" window
        # must-have if you play modded minecraft :P
        "org/gnome/mutter" = {
          check-alive-timeout = 60000;
        };
      };
    };
  };
}
