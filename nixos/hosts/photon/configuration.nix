{ outputs, lib, ... }:
{
  imports = [
    ./hardware
    ../vm/vm-specific.nix
    ./specialisations/on-the-go.nix
  ];

  usrEnv.personal = true;

  #modules.desktop.bspwm.enable = true;
  #modules.desktop.i3.enable = true;
  modules.desktop.gnome.enable = true;

  virtualisation.vmVariant = {
    modules.desktop.gnome.enable = lib.mkForce false;
    # modules.desktop.i3.enable = lib.mkForce true;
    modules.desktop.bspwm.enable = lib.mkForce true;

    # disable everything i dont need
    modules.llm.enable = lib.mkForce false;
    modules.docker.enable = lib.mkForce false;
    modules.gaming.enable = lib.mkForce false;
    modules.vpn.enable = lib.mkForce false;
  };

  #modules.vm-host.enable = true;
  modules.llm.enable = true;
  modules.docker.enable = true;
  modules.gaming.enable = true;
  modules.vpn.enable = true;

  users.users = {
    nekotori55 = {
      initialPassword = "123";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
