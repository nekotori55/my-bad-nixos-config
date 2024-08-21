{ ... }: {
  nixpkgs.overlays = [
    (
      self: super:
        {
          vkdevicechooser = super.callPackage ./vkdevicechooser.nix { };
          spoof-dpi = super.callPackage ./spoof-dpi.nix { };
        }
    )
  ];
}
