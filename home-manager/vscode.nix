{ pkgs, ... }:

let
  vscodeExtensions = with pkgs.vscode-extensions;
    [
      jnoortheen.nix-ide

      # Themes
      dracula-theme.theme-dracula

      # Go
      golang.go

      # Python
      ms-python.python
      ms-python.debugpy

      # Nix-related stuff
      mkhl.direnv
      bbenoist.nix
    ];


  settings =
    {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = "nixpkgs-fmt";
          };

          "options" = {
            "enable" = true;
          };
        };
      };
    };
in
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    #package = pkgs.vscodium; # uncomment for vscodium


    extensions = vscodeExtensions;
    userSettings = settings;
  };
}
