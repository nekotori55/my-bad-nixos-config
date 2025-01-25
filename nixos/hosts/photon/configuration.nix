{ outputs, lib, ... }:
{
  imports = [

    ./hardware

    ../vm/vm-specific.nix
    ./specialisations/on-the-go.nix

  ];

  usrEnv.personal = true;

  modules.desktop.gnome.enable = true;
  modules.vm-host.enable = true;
  modules.llm.enable = true;
  modules.docker.enable = true;
  modules.gaming.enable = true;
  modules.vpn.enable = true;

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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
