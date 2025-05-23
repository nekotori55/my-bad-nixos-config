{
  virtualisation.vmVariant = {
    services.spice-vdagentd.enable = true;

    virtualisation = {
      diskSize = 5192;
      memorySize = 2048; # Use 2048MiB memory.
      cores = 2;
      # resolution = {
      #   x = 1920;
      #   y = 1080;
      # };
    };

    virtualisation.qemu.options = [
      # Better display option
      "-vga virtio"
      "-display gtk,zoom-to-fit=false,show-cursor=on"
      # Enable copy/paste
      # https://www.kraxel.org/blog/2021/05/qemu-cut-paste/ # TODO
      "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
      "-device virtio-serial-pci"
      "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
    ];
  };
}
