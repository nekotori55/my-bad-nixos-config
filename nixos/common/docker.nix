{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.docker.enable = lib.mkEnableOption "enable docker";

  config = lib.mkIf config.docker.enable {
    environment.systemPackages = [ pkgs.docker-compose ];
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
