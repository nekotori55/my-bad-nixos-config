{ pkgs, ... }:
{
  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    cachix
  ];

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    corefonts
    vistafonts
    noto-fonts-cjk-sans
  ];
  fonts.enableDefaultPackages = true;
}
