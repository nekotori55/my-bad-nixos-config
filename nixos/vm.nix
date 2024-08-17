{
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 6;
    };

    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display sdl,gl=on,show-cursor=off"
      #     # Wire up pipewire audio
      #    "-audiodev pipewire,id=audio0"
      ##    "-device intel-hda"
      #    "-device hda-output,audiodev=audio0"
    ];
  };

  virtualisation.vmVariantWithBootLoader = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 6;
    };

    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display sdl,gl=on,show-cursor=off"
      #     # Wire up pipewire audio
      #    "-audiodev pipewire,id=audio0"
      #    "-device intel-hda"
      #    "-device hda-output,audiodev=audio0"
    ];
  };
}
