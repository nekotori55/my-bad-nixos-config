{
  pkgs,
  lib,
  config,
  ...
}:

let
  vscode-settings = import ./settings.nix;
  vscode-extensions = import ./extensions.nix pkgs;

in
{
  options.vscode.enable = lib.mkEnableOption "enable vscode";
  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      extensions = vscode-extensions;
      userSettings = vscode-settings;
    };

    # Additional packages (language servers?)
    home.packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };
}
