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
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          dns = [
            "8.8.8.8"
            "8.8.4.4"
          ];
        };
      };
    };
  };
}
