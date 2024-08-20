{...}:{
  nixpkgs.overlays = [
    (
      self: super:
      {
        vkdevicechooser = super.callPackage ./vkdevicechooser.nix {}; 
      }
    )
  ];
}