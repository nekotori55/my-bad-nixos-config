{
	pkgs,
	...
}:{
	programs.vscode = {
		enable = true;
		
		
		extensions = with pkgs.vscode-extensions; 
		[
			# Themes
			dracula-theme.theme-dracula
			
			# Go
			golang.go
			
			# Python
			ms-python.python
			ms-python.debugpy
		];
	};
	
	
	home.packages = with pkgs; [
    direnv
    
    # Self-explanatory
		docker-compose 
  ];
}
