{ pkgs, config }:
with pkgs;
(
  with vscode-extensions;
  [
    # Nix-related stuff
    mkhl.direnv
    bbenoist.nix
    jnoortheen.nix-ide

    # Themes
    dracula-theme.theme-dracula
    jdinhlife.gruvbox
  ]
  ++ lib.optionals ( config.modules.docker.enable ) [
    # Docker
    ms-azuretools.vscode-docker
  ]
  ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "nord-deep";
      publisher = "marlosirapuan";
      version = "0.1.625";
      sha256 = "sha256-5QJ1zq5vc9PdJHTtpczR/Jf6aqi8qOx/6yUru4TLiQc=";
    }
    {
      name = "nord-flat";
      publisher = "3ash";
      version = "0.5.75";
      sha256 = "sha256-W2wdqe0JLyx2pPSB1CZC0Ps6OgP7CTFCcr7rvpg03Co=";
    }
  ]
  ++ lib.optionals (config.usrEnv.discord.enable) vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscord";
      publisher = "leonardssh";
      version = "5.2.12";
      sha256 = "5860c48b3606e9402a7b58e786f8df168b970c0f58af93fe063c4f6a1008b131";
    }
  ]
)
