{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.gnomeConfigs.enable = lib.mkEnableOption "enable gnome configs";

  config = lib.mkIf config.gnomeConfigs.enable {
    #config contents
    home.packages = with pkgs; [

      gtk-engine-murrine
      gruvbox-gtk-theme
      sassc
      gnome-themes-extra

      # Gnome extensions
      gnomeExtensions.appindicator
      gnomeExtensions.pop-shell
      gnomeExtensions.user-themes
      gnomeExtensions.gravatar
      gnomeExtensions.user-avatar-in-quick-settings
      gnomeExtensions.gamemode-shell-extension
    ];

    # Gnome theming
    gtk = {
      enable = true;

      iconTheme = {
        name = "oomox-gruvbox-dark";
        package = pkgs.gruvbox-dark-icons-gtk;
      };

      cursorTheme = {
        name = "graphite-dark";
        package = pkgs.graphite-cursors;
      };

      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };

    home.sessionVariables.GTK_THEME = "Gruvbox-Dark";

    # Gnome settings
    dconf = {
      enable = true;

      settings =
        let
          keybind-base-path = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
        in
        {
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

          "org/gnome/shell/extensions/user-theme" = {
            name = "Gruvbox-Dark";
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

          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
              "/${keybind-base-path}/custom0/"
              "/${keybind-base-path}/custom1/"
              "/${keybind-base-path}/custom2/"
              "/${keybind-base-path}/custom3/"
              "/${keybind-base-path}/custom4/"
              "/${keybind-base-path}/custom5/"
            ];
          };

          "${keybind-base-path}/custom0" = {
            binding = "<Super>w";
            command = "vivaldi";
            name = "Vivaldi";
          };
          "${keybind-base-path}/custom1" = {
            binding = "<Super>t";
            command = "kgx";
            name = "Terminal";
          };
          "${keybind-base-path}/custom2" = {
            binding = "<Super>e";
            command = "nautilus";
            name = "Explorer";
          };
          "${keybind-base-path}/custom3" = {
            binding = "<Shift><Super>e";
            command = "nautilus admin:/";
            name = "Explorer (administrator mode)";
          };
          "${keybind-base-path}/custom4" = {
            binding = "<Super>c";
            command = "code /etc/nixos/";
            name = "Open NixOS config";
          };
          "${keybind-base-path}/custom5" = {
            binding = "<Shift><Super>c";
            # TODO move to script
            command = ''kgx -e "mkdir ~/nixos-vm-current; cd ~/nixos-vm-current; rm -rf *; sudo nixos-rebuild build-vm; result/bin/run-$HOSTNAME-vm"'';
            name = "Open NixOS VM";
          };
        };
    };
  };
}
