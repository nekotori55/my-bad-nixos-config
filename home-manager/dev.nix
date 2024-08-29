{ pkgs, ... }:
{
  imports = [ ./vscode.nix ];

  programs = {
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
        #".envrc"
        "**/.direnv/**"
      ];
    };
  };

  home.packages = with pkgs; [
    docker-compose
    nixd
    nixfmt-rfc-style
    gitkraken
    linuxPackages_latest.perf
    hotspot
  ];
}
