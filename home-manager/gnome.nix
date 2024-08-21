{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
  ];

  dconf = {
    enable = true;
    #settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          pop-shell.extensionUuid
        ];
      };

      # 
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
    };
  };
}
