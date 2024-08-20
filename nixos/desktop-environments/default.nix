{
  imports = [
    ./gnome.nix
  ];

  # TODO DM selector option
  services.xserver = {
    #enable = true;
    displayManager.gdm.enable = true;
  };
}
