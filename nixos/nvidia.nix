{config, lib, pkgs, ...}:
{
	hardware.opengl = {
		enable = true;
		driSupport32Bit = true;
		extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
	};

	services.xserver.videoDrivers = ["nvidia"];

	environment.systemPackages = with pkgs; [
			#lshw #  sudo lshw -c display    # to check bus id's
	];

	hardware.nvidia = {
		modesetting.enable = true;
	
		powerManagement.enable = false; # disable if artefacts
	
		powerManagement.finegrained = false; # works on turing or newer (should check)
	
		open = true; # just better
	
		nvidiaSettings = true;
	
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		
		#forceFullCompositionPipeline = true;
		
		prime = {
			# option A: Offload Mode         // nvidia sleepy - amd worky; amd can ask nvidia for help (nvidia-offload)
			# https://nixos.wiki/wiki/Nvidia
			#offload {
			#	enable = true;
			#	enableOffloadCmd = true;
			#};
			
			# option B: Sync Mode           // nvidia worky for the most,  but nvidia eats a lot (of energy)
			sync.enable = true;
			
			# option C: Reverse Sync Mode (experimental)     // amd worky but good external monitors compat i guesss
			#reverseSync.enable = true;
			#allowExternalGpu = false; #// I guess my gpu is very internal
			
			amdgpuBusId = "PCI:5:0:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	};
	
	
	specialisation = {
  	on-the-go.configuration = {
  	  system.nixos.tags = [ "on-the-go" ];
  	  hardware.nvidia = {
  	    prime.offload.enable = lib.mkForce true;
  	    prime.offload.enableOffloadCmd = lib.mkForce true;
  	    prime.sync.enable = lib.mkForce false;
  	    
  	    powerManagement.enable = lib.mkForce true; # disable if artefacts
				powerManagement.finegrained = lib.mkForce true; # works on turing or newer (should check)
  	  };
  	};
	};

}
