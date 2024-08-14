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
			
			
		];
	};
}
