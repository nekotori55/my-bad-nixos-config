{ outputs, lib, ... }:
{
  imports = [

    ./hardware

    ../vm/vm-specific.nix
    ./specialisations/on-the-go.nix

  ];

  vm-manager.enable = true;
  ai.enable = true;
  docker.enable = true;
  gaming.enable = true;

  users.users = {
    nekotori55 = {
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
