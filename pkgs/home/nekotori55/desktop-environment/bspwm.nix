{
  osConfig,
  lib,
  ...
}:
{
  config = lib.mkIf osConfig.modules.desktop.bspwm.enable {
    xsession.windowManager.bspwm.enable = true;
  };
}
