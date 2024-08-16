{ pkgs, ... }:
{
  imports = [
    ./vscode.nix
  ];

  programs = {
    bash = {
      enable = true; # allow homemanager to manage shell
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "Nekotori";
      userEmail = "nekotori55@gmail.com";

      ignores = [
        ".envrc"
        ".direnv/**"
      ];
    };
  };

  
  home.packages = with pkgs; [
    docker-compose
    nixd
    nixpkgs-fmt
    gitkraken
  ];
}
