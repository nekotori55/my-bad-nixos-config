{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.desktop.bspwm.enable {
    services.xserver = {
      enable = true;
      # windowManager.bspwm.enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.sddm.enable = true;

      xkb = {
        layout = "us,ru";
        variant = "";
        options = "grp:alt_shift_toggle";
      };
    };
  };
}
