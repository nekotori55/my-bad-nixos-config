{ config, lib, ... }:
{
  options.ai.enable = lib.mkEnableOption "enable ollama module";

  config = lib.mkIf config.ai.enable {

    # Ollama
    services.ollama = {
      enable = true;
      acceleration = "cuda";
      port = 11111;
    };
  };
}
