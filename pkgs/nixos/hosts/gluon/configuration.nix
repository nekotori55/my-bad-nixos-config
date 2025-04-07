{ outputs, lib, ... }:
{
  imports = [
    ./hardware
    ../vm/vm-specific.nix
  ];

  users.users = {
    nekotori55 = {
      initialPassword = "changeme";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  services.xserver.displayManager.gdm.enable = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 15d";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
