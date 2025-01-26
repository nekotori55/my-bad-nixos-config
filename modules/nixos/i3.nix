{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.modules.desktop.i3.enable {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
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
