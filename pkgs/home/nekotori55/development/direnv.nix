{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      ignores = [
        "**/.direnv/**"
      ];
    };
  };
}
