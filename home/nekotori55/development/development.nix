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
      # jetbrains.idea-community-bin
      # jetbrains.rider
      # jetbrains.goland
    ];

    vscode.enable = true;

    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };

      git = {
        enable = true;
        ignores = [
          #".envrc"
          "**/.direnv/**"
        ];
        includes = [
          {
            condition = "gitdir:~/s";
            contents = {
              core.filemode = false;
            };
          }
        ];
      };
    };
  };
}
