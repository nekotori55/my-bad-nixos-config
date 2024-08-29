{
  imports = [ ./gnome.nix ];

  # TODO DM selector option
  services.xserver = {
    displayManager = {
      gdm.enable = true;
    };
  };
}
