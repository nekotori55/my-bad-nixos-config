{ pkgs
, ...
}: {
  # GNOME
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    #gnome-terminal
    #gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

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
