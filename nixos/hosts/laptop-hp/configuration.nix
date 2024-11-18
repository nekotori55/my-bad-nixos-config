{ outputs, lib, ... }:
{
  imports = [
    outputs.nixosModules.gnomeMinimal

    ./hardware

    ../vm/vm-specific.nix
    ./specialisations/on-the-go.nix

    ../../common
  ];

  vm-manager.enable = true;
  ai.enable = true;
  docker.enable = true;
  gaming.enable = true;

  users.users = {
    kefrnik = {
      initialPassword = "aboba";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" ];
    };
  };

  services.xserver.displayManager.gdm.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # to autostart nekoray tun mode without sudo prompt
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        action.id == "org.freedesktop.policykit.exec" &&
        (action.lookup("command_line").indexOf(' /home/' + subject.user + '/.config/nekoray/config/vpn-run-root.sh') !== -1)
        )
      {
        return polkit.Result.YES;
      }
    });
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
