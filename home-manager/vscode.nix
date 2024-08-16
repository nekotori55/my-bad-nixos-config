{ pkgs, ... }:

let 
  vscodeExtensions = with pkgs.vscode-extensions;
  [
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
    jnoortheen.nix-ide
  ];
in 
{
  programs.vscode = {
		enable = true;
		#package = pkgs.vscodium; # uncomment for vscodium
		extensions = vscodeExtensions;
	};
}