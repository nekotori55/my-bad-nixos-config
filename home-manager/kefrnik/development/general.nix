{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.development.enable = lib.mkEnableOption "enable development";
  config = lib.mkIf config.development.enable {
    home.packages = with pkgs; [
      gitkraken
      linuxPackages_latest.perf
      hotspot

      jetbrains.idea-community-bin
      jetbrains.rider
      jetbrains.goland
    ];

    vscode.enable = true;
    direnv.enable = true;

    programs.git.enable = true;
  };
}
