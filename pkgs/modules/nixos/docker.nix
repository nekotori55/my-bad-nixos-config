{
  pkgs,
  lib,
  config,
  ...
}:
{

  config = lib.mkIf config.modules.docker.enable {
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
