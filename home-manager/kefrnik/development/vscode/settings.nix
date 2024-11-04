{
  # EDITOR SETTINGS
  "editor.formatOnSave" = true;
  "workbench.colorTheme" = "Gruvbox Dark Medium";
  "window.restoreWindows" = "none";
  "git.enableSmartCommit" = true;
  "git.confirmSync" = false;
  "explorer.confirmDelete" = false;
  "extensions.ignoreRecommendations" = true;
  "editor.minimap.enabled" = false;

  # EXTENSIONS SETTINGS
  # 
  # Nix IDE
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nixd";
  "nix.serverSettings" = {
    "nixd" = {
      "formatting" = {
        "command" = "nixfmt";
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
      "condition" = [ "always" ];
      "command" = "python.clearWorkspaceInterpreter";
      "message" = "Super condition met. Running";
    }
  ];

  # direnv settings
  "direnv.restart.automatic" = true;

  "vscord.behaviour.suppressNotifications" = true;
}
