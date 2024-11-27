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
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      corefonts
      vistafonts
      noto-fonts-cjk-sans
      nerdfonts
    ];

    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        monospace = [ "Hack Nerd Mono" ];
      };
    };

    enableDefaultPackages = true;

  };
  programs.nh.enable = true;
}
