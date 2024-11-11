{
  pkgs,
  config,
  lib,
  outputs,
  ...
}:
{
  imports = [
    outputs.homeManagerModules.gnomeKeybindings
  ];

  options.gnomeConfigs.enable = lib.mkEnableOption "enable gnome configs";

  config = lib.mkIf config.gnomeConfigs.enable {
    #config contents
    home.packages = with pkgs; [
      # Gnome extensions
      gnomeExtensions.appindicator
      gnomeExtensions.pop-shell
      gnomeExtensions.gravatar
      gnomeExtensions.user-avatar-in-quick-settings
      gnomeExtensions.gamemode-shell-extension
    ];

    programs.gnome-shell = {
      # Enable gnome customisation using home-manager
      enable = true;

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

    # Gnome settings
    dconf = {
      enable = true;

      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            appindicator.extensionUuid
            pop-shell.extensionUuid
            user-themes.extensionUuid
            x11-gestures.extensionUuid
            transparent-top-bar.extensionUuid
            gravatar.extensionUuid
            user-avatar-in-quick-settings.extensionUuid
            gamemode-shell-extension.extensionUuid
          ];
        };

        "org/gnome/desktop/background" =
          let
            username = config.home.username;
            bg = "file:///home/${username}/.wallpaper.png";
          in
          {
            picture-uri = "${bg}";
            picture-uri-dark = "${bg}";
          };

        "org/gnome/mutter" = {
          check-alive-timeout = 60000;
        };
      };
    };
  };
}
