{ lib, config, ... }:
let
  gnome = config.services.xserver.desktopManager.gnome;
in
{
  imports = [
    ./gnome.nix
  ];

  config = lib.mkIf gnome.enable {

  };
}
