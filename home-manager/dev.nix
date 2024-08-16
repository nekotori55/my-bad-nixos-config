{	pkgs,	... }:

let	
	vscode = import ./vscode.nix;		
in
{
  imports = [
    ./vscode.nix
  ];
	
	programs = {
    bash = {
    	enable = true; # allow homemanager to manage shell
    };

    direnv = {
      enable = true;
      enableBashIntegration = true; 
      nix-direnv.enable = true;
    };
  };
	

	home.packages = with pkgs; [
		docker-compose 
    nixd
  ];

}
