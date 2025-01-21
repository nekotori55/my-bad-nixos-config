{ lib, ... }:
let
  inherit (lib) mkOption;
in
{
  imports = [
    ./home
    ./nixos
  ];

  options.custom = mkOption {

  };
}
