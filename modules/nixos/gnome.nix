{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.modules.desktop.gnome.enable {
  # GNOME
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-boxes
  ];

  services.gnome = {
    core-utilities.enable = false;
    games.enable = false;
  };

  # TODO rewrite using special nixos options like gnome.games.enable
  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
    ]
  );

  # Configure keymap in X11
  # For gnome works only for the first launch,
  # Because gnome uses it's own settings generated from these values
  # To reset this settings use:
  #   gsettings reset org.gnome.desktop.input-sources xkb-options
  #   gsettings reset org.gnome.desktop.input-sources sources
  # and then logout to re-generate settings
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };
  };
}
