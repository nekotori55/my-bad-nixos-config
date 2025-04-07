{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;

      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };

      nixosConfigurations = {
        photon = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };

          modules = [
            ./modules/options
            ./modules/nixos
            ./nixos/hosts/photon/configuration.nix
            ./cachix.nix
            ./overlays

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs outputs;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nekotori55 = import ./home/nekotori55;
              home-manager.backupFileExtension = ".old";
              home-manager.sharedModules = [
                ./modules/home-manager
              ];
            }
          ];
        };

        gluon = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };

          modules = [
            ./modules/options
            ./modules/nixos
            ./nixos/hosts/gluon/configuration.nix
            ./cachix.nix
            ./overlays

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs outputs;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nekotori55 = import ./home/nekotori55;
              home-manager.backupFileExtension = ".old";
            }
          ];
        };
      };
    };
}
