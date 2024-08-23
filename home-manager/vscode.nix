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

      # C++
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      twxs.cmake

    ] ++ vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "auto-run-command";
        publisher = "gabrielgrinberg";
        version = "1.6.0";
        sha256 = "c6c242bc20be7921b0f7ece019549d0d1156a3ab10831c8f3ccc0b4704eee57e";
      }
      {
        name = "vscord";
        publisher = "leonardssh";
        version = "5.2.12";
        sha256 = "5860c48b3606e9402a7b58e786f8df168b970c0f58af93fe063c4f6a1008b131";
      }

      # CLIPS (god save me)
      {
        name = "clips-ide";
        publisher = "algono";
        version = "1.2.3";
        sha256 = "sha256-/ZuX0j5p0rN2iWc4Z09u3eNMWS2KihWbQkJ3XCTbcdM=";
      }
      {
        name = "clips-lang";
        publisher = "nerg";
        version = "1.0.4";
        sha256 = "sha256-e89t7earU88a/envfJvjRfBDmGriYKtw5e+yPptop5M=";
      }
      {
        name = "nsight-vscode-edition";
        publisher = "nvidia";
        version = "2024.1.34572442";
        sha256 = "sha256-yEffpXNmePpzZcX46dkK8Ic9gffZD+djlPx5HV3F2oE=";
      }
    ]);


  settings =
    {
      # EDITOR SETTINGS
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = "Dracula";
      "window.restoreWindows" = "none";

      # EXTENSIONS SETTINGS
      # 
      # Nix IDE
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

      # Python settings
      "python.defaultInterpreterPath" = "\${env:PYTHONPATH}";

      # Auto Run Command settings
      "auto-run-command.rules" = [
        {
          "condition" = [
            "always"
          ];
          "command" = "python.clearWorkspaceInterpreter";
          "message" = "Super condition met. Running";
        }
      ];

      # direnv settings
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
