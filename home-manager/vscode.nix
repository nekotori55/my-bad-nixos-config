{ pkgs, ... }:

let
  vscodeExtensions = with pkgs;
    (with vscode-extensions;
    [
      # Nix-related stuff
      mkhl.direnv
      bbenoist.nix
      jnoortheen.nix-ide

      # Themes
      dracula-theme.theme-dracula

      # Go
      golang.go

      # Python
      ms-python.python
      ms-python.debugpy
      ms-python.vscode-pylance
      ms-python.black-formatter

    ] ++ vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "auto-run-command";
        publisher = "gabrielgrinberg";
        version = "1.6.0";
        sha256 = "c6c242bc20be7921b0f7ece019549d0d1156a3ab10831c8f3ccc0b4704eee57e";
      }
    ]);


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

      "workbench.colorTheme" = "Dracula";

      "python.defaultInterpreterPath" = "\${env:PYTHONPATH}";

      "auto-run-command.rules" = [
        {
          "condition" = [
            "always"
          ];
          "command" = "python.clearWorkspaceInterpreter";
          "message" = "Super condition met. Running";
        }
      ];

      "direnv.restart.automatic" = true;
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
