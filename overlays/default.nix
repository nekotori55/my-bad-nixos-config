{ ... }:
{
  ...
}:
let
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
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
