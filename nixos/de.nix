{
  pkgs,
  ...
}: {
	# GNOME
  services.xserver = {
  	enable = true;
  	displayManager.gdm.enable = true;
  	desktopManager.gnome.enable = true;
	};

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
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };
  
  ##################################
  
  
  # HYPRLAND
  programs.hyprland.enable = false;
  
}
