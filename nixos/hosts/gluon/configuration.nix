{ outputs, lib, ... }:
{
  imports = [
    ./hardware
  ];

  users.users = {
    nekotori55 = {
      initialPassword = "changeme";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  modules.desktop.gnome.enable = false;
  modules.desktop.i3.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
