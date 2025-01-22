{ lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkDefault;
in
{
  options.programs.gnome-shell.autogroup-apps = mkEnableOption "autogroup gnome apps";

  config = mkIf config.programs.gnome-shell.autogroup-apps {
    dconf = {
      enable = mkDefault true;

      settings =
        let
          base-path = "org/gnome/desktop/app-folders";
          folder-base-path = "${base-path}/folders";
        in
        {
          "${base-path}" = {
            folder-children = [
              "internet"
              "games"
              "accessories"
              "graphics"
              "office"
              "programming"
              "science"
              "sound-video"
              "system-tools"
            ];
          };

          "${folder-base-path}/internet" = {
            name = "Internet";
            categories = [
              "Network"
              "WebBrowser"
              "Email"
            ];
          };

          "${folder-base-path}/games" = {
            name = "Games";
            categories = [
              "Game"
            ];
          };

          "${folder-base-path}/graphics" = {
            name = "Graphics";
            categories = [
              "Graphics"
            ];
          };

          "${folder-base-path}/accessories" = {
            name = "Tools";
            categories = [
              "Utility"
            ];
          };

          "${folder-base-path}/office" = {
            name = "Office";
            categories = [
              "Office"
            ];
          };

          "${folder-base-path}/programming" = {
            name = "Development";
            categories = [
              "Development"
            ];
          };

          "${folder-base-path}/science" = {
            name = "Science";
            categories = [
              "Science"
            ];
          };

          "${folder-base-path}/sound-video" = {
            name = "Sound & Video";
            categories = [
              "AudioVideo"
              "Audio"
              "Video"
            ];
          };

          "${folder-base-path}/system-tools" = {
            name = "System Tools";
            categories = [
              "System"
              "Settings"
            ];
          };
        };
    };
  };
}
