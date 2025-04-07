{ config, lib, ... }:
{
  config = lib.mkIf config.modules.llm.enable {

    # Ollama
    services.ollama = {
      enable = true;
      acceleration = "cuda";
      port = 11111;
    };
  };
}
