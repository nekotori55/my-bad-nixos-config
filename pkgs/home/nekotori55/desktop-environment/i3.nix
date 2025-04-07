{
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf osConfig.modules.desktop.i3.enable {
    home.packages = with pkgs; [
      feh
    ];

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = {
        # Set Windows Key as modifier key
        modifier = "Mod4";

        gaps = {
          inner = 10;
          outer = 5;
        };

        startup = [
          {
            command = " xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 120 --right-of eDP-1-0";
          }
          # Wallpaper (using feh)
          {
            command = "feh --bg-scale --no-fehbg ~/.wallpaper.png";
            notification = false;
          }
        ];

        # keycodebindings = [

        # ];

      };
    };

    services.picom = {
      enable = true;

      settings = {
        shadow = false;
        shadow-radius = 7;
        shadow-offset-x = -7;
        shadow-offset-y = -7;
        shadow-exclude = [
          "rofi"
          "name = 'Notification'"
          "class_g = 'Conky'"
          "class_g ?= 'Notify-osd'"
          "class_g = 'Cairo-clock'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        fading = false;
        fade-in-step = 0.03;
        fade-out-step = 0.03;
        active-opacity = 1;
        inactive-opacity = 0.9;
        frame-opacity = 0.8;
        inactive-opacity-override = false;
        focus-exclude = [ "class_g = 'alacritty'" ];
        corner-radius = 0;
        rounded-corners-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];
        blur-kern = "3x3box";
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        backend = "xrender";
        vsync = true;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        use-damage = true;
        log-level = "warn";
        wintypes = {
          tooltip = {
            fade = true;
            shadow = true;
            opacity = 0.75;
            focus = true;
            full-shadow = false;
          };
          dock = {
            shadow = false;
            clip-shadow-above = true;
          };
          dnd = {
            shadow = false;
          };
          popup_menu = {
            opacity = 0.8;
          };
          dropdown_menu = {
            opacity = 0.8;
          };
        };

      };

    };
  };
}
