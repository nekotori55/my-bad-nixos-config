{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  options.modules = {
    desktop = {
      gnome = {
        enable = mkEnableOption "Enable gnome";
      };
      bspwm = {
        enable = mkEnableOption "Enable bspwm";
      };
      i3 = {
        enable = mkEnableOption "Enable i3 wm";
      };
    };

    docker.enable = mkEnableOption "Enable docker";
    vm-host.enable = mkEnableOption "Enable vm host programs";
    llm.enable = mkEnableOption "Enable Local Language Models";
    gaming.enable = mkEnableOption "Enable gaming module";
    vpn.enable = mkEnableOption "Enable vpn";
  };

  options.usrEnv = {
    blocked-apps = mkEnableOption "Enable download of blocked apps";
    personal = mkEnableOption "Is this host for personal usage";
    discord.enable = mkEnableOption "enable discord";
  };
}
