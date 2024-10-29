{ lib, config, ... }:
{
  options.direnv.enable = lib.mkEnableOption "enable docker";

  config = lib.mkIf config.direnv.enable {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };

      git = {
        ignores = [
          #".envrc"
          "**/.direnv/**"
        ];
      };
    };
  };
}
