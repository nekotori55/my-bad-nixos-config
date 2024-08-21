{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , unstable
    , ...
    } @ inputs:
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
          #system = "x86_64-linux";
          specialArgs = {
            pkgs-unstable = import unstable {
              config.allowUnfree = true;
              system = "x86_64-linux";
            };
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
            }
          ];
        };
      };
    };
}

