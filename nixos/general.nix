{ pkgs, ... }:
{
  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    cachix
  ];

  users.users = {
    kefrnik = {
      initialPassword = "aboba";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" ];
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    corefonts
    vistafonts
    noto-fonts-cjk-sans
  ];
  fonts.enableDefaultPackages = true;

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  # Ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    port = 11111;
  };
}
