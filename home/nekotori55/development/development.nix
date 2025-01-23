{
  pkgs,
  osConfig,
  lib,
  ...
}:
{
  config = lib.mkIf osConfig.usrEnv.development.enable {
    home.packages = with pkgs; [ ];

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
      };
    };
  };
}
