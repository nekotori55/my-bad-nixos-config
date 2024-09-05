{ lib, config, ... }:
{
  options.vm-manager.enable = lib.mkEnableOption "enable vms module";

  config = lib.mkIf config.vm-manager.enable {
    # # Virtualbox
    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

    # virt-manager + gnome boxes
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
