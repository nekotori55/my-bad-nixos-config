{	pkgs,	... }:

let	
	vscodeExtensions = import ./vscode-default-extensions.nix { pkgs = pkgs; };		
in
{
	programs.vscode = {
		enable = true;
		#package = pkgs.vscode;
		
		extensions = vscodeExtensions;
	};

	
	programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; 
      nix-direnv.enable = true;
    };

    bash = {
    	enable = true; # allow homemanager to manage shell
    };
  };
	

	home.packages = with pkgs; [
    
    # Self-explanatory
		docker-compose 
  ];
}
