# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  config,
  pkgs,
  lib,
  ...
}: {

  home = {
    username = "kefrnik";
    homeDirectory = "/home/kefrnik";
  };
  
  programs.home-manager.enable = true;
  
  imports = [
  	#./hyprland.nix
  	./dev.nix
  	./gnome.nix
  ];
  
  
	home.packages = with pkgs; [
		neofetch
		cowsay
		firefox
		
		telegram-desktop
		vesktop
	];


  programs.firefox.enable = true;

  programs.git = {
  	enable = true;
  	userName = "Nekotori";
  	userEmail = "nekotori55@gmail.com";
  };
    

    
	home.sessionVariables.NIXOS_OZONE_WL = "1";
	home.sessionVariables.EDITOR = "gnome-text-editor";
	
	
  

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
