{ pkgs, ... }:
{
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
    gitkraken
    linuxPackages_latest.perf
    hotspot
  ];
}
