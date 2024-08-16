{ pkgs, ... }:

let
  vscodeExtensions = with pkgs.vscode-extensions;
    [
      jnoortheen.nix-ide

      # Themes
      dracula-theme.theme-dracula

      # Go
      golang.go

      # Python
      ms-python.python
      ms-python.debugpy

      # Nix-related stuff
      mkhl.direnv
      bbenoist.nix
    ];
in
{
  nixpkgs = {
    config = {
      #      allowUnfree = true;
      #allowUnfreePredicate = (_: true);
    };
  };


  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium; # uncomment for vscodium
    extensions = vscodeExtensions;
  };
}
