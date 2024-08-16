{ pkgs, ... }:
{
  programs = {
    bash = {
      enable = true; # allow homemanager to manage shell
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };

  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    docker-compose
    nixd
    nixpkgs-fmt
  ];

}
