{ pkgs, ... }:
{
  gtk = {
    # Enable gtk customization
    enable = true;

    theme = {
      name = "Nordic-bluish-accent";
      package = pkgs.nordic;
    };

    iconTheme = {
      name = "Nordzy-dark";
      package = pkgs.nordzy-icon-theme;
    };

    cursorTheme = {
      name = "Nordzy-cursors-white";
      package = pkgs.nordzy-cursor-theme;
    };
  };
}
