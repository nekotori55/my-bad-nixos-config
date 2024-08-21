{ pkgs, ... }:
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
          #bg = "https://w.wallhaven.cc/full/r2/wallhaven-r2dz6w.jpg";
          #bg = "https://w.wallhaven.cc/full/kx/wallhaven-kxe8z7.jpg";
          bg = "https://w.wallhaven.cc/full/m3/wallhaven-m35z1k.png";
          #bg = "file://~.wallpaper.png";
        in
        {
          picture-uri = "${bg}";
          picture-uri-dark = "${bg}";
        };
    };
  };
}
