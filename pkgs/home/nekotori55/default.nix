{
  imports = [
    ./nekotori55.nix
    ./shell.nix
    ./desktop-environment/default.nix
    ./development/default.nix
  ];

  home.stateVersion = "23.05";
}
