{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
  ];

  dconf = {
    enable = true;

    settings = let keybind-base-path = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"; in {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          pop-shell.extensionUuid
        ];
      };

      "org/gnome/mutter" = {
        check-alive-timeout = 60000;
      };

      "org/gnome/desktop/background" =
        let
          username = config.home.username;
          bg = "file:///home/${username}/Pictures/wallpaper.png";
        in
        {
          picture-uri = "${bg}";
          picture-uri-dark = "${bg}";
        };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/${keybind-base-path}/custom0/"
          "/${keybind-base-path}/custom1/"
          "/${keybind-base-path}/custom2/"
          "/${keybind-base-path}/custom3/"
        ];
      };

      "${keybind-base-path}/custom0" = {
        binding = "<Super>w";
        command = "firefox";
        name = "Firefox";
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
    };
  };
}
