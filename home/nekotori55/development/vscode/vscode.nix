{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
  vscode-settings = import ./settings.nix;
  vscode-extensions = import ./extensions.nix { pkgs config };

in
{
  config = lib.mkIf osConfig.usrEnv.development.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = true;
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
