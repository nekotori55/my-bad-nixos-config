{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };

      nixosConfigurations = {
        nixos-xx = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };

          modules = [
            ./nixos/configuration.nix
            ./cachix.nix
            ./pkgs/default.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kefrnik = import ./home-manager/home.nix;
              home-manager.backupFileExtension = ".old";
            }
          ];
        };
      };
    };
}
