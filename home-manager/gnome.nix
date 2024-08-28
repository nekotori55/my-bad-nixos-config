{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    gruvbox-gtk-theme
    gruvbox-dark-icons-gtk
    gnomeExtensions.user-themes
    gtk-engine-murrine
    sassc
    gnome-themes-extra
    graphite-cursors
  ];

  home.file.".wallpaper.png".source = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/3l/wallhaven-3lyrvy.png";
    sha256 = "1angwl1knhjxv3hfr6dzrnm7xzkgxv6vbv8ny2bkmr9f9wk6mwd8";
  };

  dconf = {
    enable = true;

    settings = let keybind-base-path = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"; in {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          pop-shell.extensionUuid
          user-themes.extensionUuid
        ];
      };

      "org/gnome/mutter" = {
        check-alive-timeout = 60000;
      };

      "org/gnome/desktop/background" =
        let
          username = config.home.username;
          bg = "file:///home/${username}/.wallpaper.png";
        in
        {
          picture-uri = "${bg}";
          picture-uri-dark = "${bg}";
        };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/${keybind-base-path}/custom0/"
          "/${keybind-base-path}/custom1/"
          "/${keybind-base-path}/custom2/"
          "/${keybind-base-path}/custom3/"
          "/${keybind-base-path}/custom4/"
          "/${keybind-base-path}/custom5/"
        ];
      };

      "${keybind-base-path}/custom0" = {
        binding = "<Super>w";
        command = "firefox";
        name = "Firefox";
      };
      "${keybind-base-path}/custom1" = {
        binding = "<Super>t";
        command = "kgx";
        name = "Terminal";
      };
      "${keybind-base-path}/custom2" = {
        binding = "<Super>e";
        command = "nautilus";
        name = "Explorer";
      };
      "${keybind-base-path}/custom3" = {
        binding = "<Shift><Super>e";
        command = "nautilus admin:/";
        name = "Explorer (administrator mode)";
      };
      "${keybind-base-path}/custom4" = {
        binding = "<Super>c";
        command = "code /etc/nixos/";
        name = "Open NixOS config";
      };
      "${keybind-base-path}/custom5" = {
        binding = "<Shift><Super>c";
        # TODO move to script
        command = ''kgx -e "mkdir ~/nixos-vm-current; cd ~/nixos-vm-current; rm -rf *; sudo nixos-rebuild build-vm; result/bin/run-$HOSTNAME-vm"'';
        name = "Open NixOS VM";
      };
    };
  };
}
