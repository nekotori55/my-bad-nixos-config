{ pkgs }:

with pkgs.vscode-extensions;
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
]
