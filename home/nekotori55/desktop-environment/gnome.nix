{
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs) gnomeExtensions;
in
{
  programs.gnome-shell = {
    gnome-shell.enable = true;

    extensions = [
      { package = gnomeExtensions.appindicator; }
      { package = gnomeExtensions.pop-shell; }
      { package = gnomeExtensions.gravatar; }
      { package = gnomeExtensions.user-avatar-in-quick-settings; }
      { package = gnomeExtensions.blur-my-shell; }
      { package = gnomeExtensions.transparent-top-bar-adjustable-transparency; }
    ];

    theme = {
      name = "Nordic-bluish-accent";
      package = pkgs.nordic;
    };

    # Create custom keybindings
    custom-keybindings = {
      browser = {
        binding = "<Super>w";
        command = "vivaldi";
      };

      terminal = {
        binding = "<Super>t";
        command = "alacritty";
      };

      explorer = {
        binding = "<Super>e";
        command = "nautilus";
      };

      explorer-admin = {
        binding = "<Shift><Super>e";
        command = "nautilus admin:/";
      };

      nixos-config = {
        binding = "<Super>c";
        command = "code /etc/nixos/";
      };

    };
  };

  # Other settings
  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/background" =
        let
          username = config.home.username;
          bg = "file:///home/${username}/.wallpaper.png";
        in
        {
          picture-uri = "${bg}";
          picture-uri-dark = "${bg}";
        };

      # set time before gnome shows "app is not responding" window
      # must-have if you play modded minecraft :P
      "org/gnome/mutter" = {
        check-alive-timeout = 60000;
      };
    };
  };
}
