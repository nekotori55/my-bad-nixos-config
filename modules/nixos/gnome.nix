{ pkgs, ... }:
{
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

  # TODO rewrite using special nixos options like gnome.games.enable
  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-photos
      gnome-tour
      cheese # webcam tool
      gnome-music
      gnome-weather
      gnome-contacts
      yelp
      epiphany # web browser
      # geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
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
}
