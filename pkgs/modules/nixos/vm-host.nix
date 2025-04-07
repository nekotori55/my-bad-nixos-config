{ lib, config, ... }:
{
  config = lib.mkIf config.modules.vm-host.enable {
    # # Virtualbox
    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

    # virt-manager + gnome boxes
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    virtualisation.vmware.host.enable = true;
  };
}
