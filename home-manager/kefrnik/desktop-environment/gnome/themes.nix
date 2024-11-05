{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  themePresets = {
    "gruvbox-dark" = {
      packages = with pkgs; [
        gruvbox-gtk-theme
        gtk-engine-murrine
        sassc
      ];
      GTK_THEME = "Gruvbox-Dark";
      gtk2Theme = "Gruvbox-Dark";
      iconTheme = {
        name = "oomox-gruvbox-dark";
        package = pkgs.gruvbox-dark-icons-gtk;
      };
      cursorTheme = {
        name = "graphite-dark";
        package = pkgs.graphite-cursors;
      };
    };

    "light-theme" = {
      packages = [ ];
      GTK_THEME = "Adwaita";
      gtk2Theme = "Adwaita";
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    "custom-theme" = {
      packages = [ ];
      GTK_THEME = config.customTheme.GTK_THEME or "Adwaita";
      gtk2Theme = config.customTheme.gtk2Theme or "Adwaita";
      iconTheme =
        config.gnome.customTheme.iconTheme or {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };
      cursorTheme =
        config.gnome.customTheme.cursorTheme or {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };
    };
  };

  # Fetch the selected theme preset, with a fallback in case of missing selection.
  selectedPreset = themePresets.${config.gnomeConfigs.theme} or themePresets."light-theme";
in
{
  options.gnomeConfigs.theme = mkOption {
    type = types.enum [
      "gruvbox-dark"
      "light-theme"
      "custom-theme"
    ];
    default = "gruvbox-dark";
    description = "Selects the GNOME theme preset to use.";
  };

  config = lib.mkIf config.gnomeConfigs.enable {
    #config contents
    home.packages =
      with pkgs;
      [
        gnome-themes-extra
        gnomeExtensions.user-themes
      ]
      ++ selectedPreset.packages;

    # Gnome theming
    gtk.enable = true;

    home.sessionVariables = {
      GTK_THEME = selectedPreset.GTK_THEME;
      # GTK2_RC_FILES = "${pkgs.gtk2}/etc/gtk-2.0/gtkrc:/share/themes/${selectedPreset.gtk2Theme}/gtk-2.0/gtkrc"; # For legacy theme
    };
    gtk.iconTheme = mkDefault selectedPreset.iconTheme;
    gtk.cursorTheme = mkDefault selectedPreset.cursorTheme;
    gtk.theme.name = selectedPreset.gtk2Theme;
    # gtk.gtk2.theme = selectedPreset.gtk2Theme; # Legacy

    gtk.gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
    gtk.gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
  };
}
