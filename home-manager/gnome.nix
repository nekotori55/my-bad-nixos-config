{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
  ];

  dconf = {
    enable = true;
    #settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
        ];
      };

      "org/gnome/desktop/background" = 
        let
          bg = "https://w.wallhaven.cc/full/r2/wallhaven-r2dz6w.jpg";
        in
        {
          picture-uri = "${bg}";
          picture-uri-dark = "${bg}";
        };
    };
  };
}
