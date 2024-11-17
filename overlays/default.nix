{
  ...
}:
let
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    # Replace vesktop icon with discord one
    vesktop = prev.vesktop.overrideAttrs (e: {
      desktopItems = (builtins.elemAt e.desktopItems 0).override (d: {
        # Requires iconpack with discord icon or discord installed
        icon = "discord";
      });
    });
  };
in
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      additions
      modifications
    ];
  };
}
