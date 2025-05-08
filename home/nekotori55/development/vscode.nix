{ pkgs, lib, osConfig, ... }: {
  home.packages = with pkgs; [ nixd nixfmt-rfc-style ];

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = true;
    extensions = with pkgs;
      (with vscode-extensions;
        [
          # Nix-related stuff
          mkhl.direnv
          bbenoist.nix
          jnoortheen.nix-ide
          ms-azuretools.vscode-docker
        ] ++ vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "nord-deep";
            publisher = "marlosirapuan";
            version = "0.1.625";
            sha256 = "sha256-5QJ1zq5vc9PdJHTtpczR/Jf6aqi8qOx/6yUru4TLiQc=";
          }
          {
            name = "nord-flat";
            publisher = "3ash";
            version = "0.5.75";
            sha256 = "sha256-W2wdqe0JLyx2pPSB1CZC0Ps6OgP7CTFCcr7rvpg03Co=";
          }
          {
            name = "vscord";
            publisher = "leonardssh";
            version = "5.2.12";
            sha256 =
              "5860c48b3606e9402a7b58e786f8df168b970c0f58af93fe063c4f6a1008b131";
          }
        ]);
    userSettings = {
      # EDITOR SETTINGS
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = "Nord Flat";
      "window.restoreWindows" = "none";
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "explorer.confirmDelete" = false;
      "extensions.ignoreRecommendations" = true;
      "editor.minimap.enabled" = false;
      "window.menuBarVisibility" = "toggle";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = { "command" = "nixfmt"; };
          "options" = { "enable" = true; };
        };
      };
      "python.defaultInterpreterPath" = "\${env:PYTHONPATH}";
      "auto-run-command.rules" = [{
        "condition" = [ "always" ];
        "command" = "python.clearWorkspaceInterpreter";
        "message" = "Super condition met. Running";
      }];
      "direnv.restart.automatic" = true;
      "vscord.behaviour.suppressNotifications" = true;
    };
  };
}
