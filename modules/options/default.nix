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
      hyprland = {
        enable = mkEnableOption "Enable hyprland";
      };
    };

    docker.enable = mkEnableOption "Enable docker";
  };

  options.usrEnv = {
    blocked-apps = mkEnableOption "Enable download of blocked apps";

    development = {
      enable = mkEnableOption "enable dev module";
      vscode = {
        enable = mkEnableOption "Enable vscode";
      };
    };

    personal = mkEnableOption "Is this host for personal usage";

    discord.enable = mkEnableOption "enable discord";
  };
}
