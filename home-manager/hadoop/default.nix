{ pkgs, ... }:
{
  home = {
    username = "hadoop";
    homeDirectory = "/home/hadoop";
  };

  imports = [
    ../common
  ];

  # Wallpaper
  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/3l/wallhaven-3lyrvy.png";
    sha256 = "1angwl1knhjxv3hfr6dzrnm7xzkgxv6vbv8ny2bkmr9f9wk6mwd8";
  };

  gnomeConfigs.enable = true;

  home.packages = with pkgs; [ ];

}
