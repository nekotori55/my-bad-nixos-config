{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos-xx = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        
        modules = [
        	./nixos/configuration.nix
        	
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
