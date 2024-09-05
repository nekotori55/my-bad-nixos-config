{ outputs, lib, ... }:
{

  imports = [
    outputs.nixosModules.gnomeMinimal

    ../../common
    ../vm/vm-specific.nix
  ];

  users.users = {
    hadoop = {
      initialPassword = "aboba";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

}
