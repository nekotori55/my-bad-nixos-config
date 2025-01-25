{ config, lib, ... }:
{
  config = lib.mkIf config.modules.desktop.bspwm.enable {

  };
}
