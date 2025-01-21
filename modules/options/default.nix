{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{

  options.modules.desktop = {
    gnome = {
      enable = mkEnableOption "Enable gnome";
    };
  };

}
