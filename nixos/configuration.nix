# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
    ./de.nix  
  ];
	
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };
  
  # Bootloader.
  boot.loader = {
  	grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
			useOSProber = true;
		};
		efi.canTouchEfiVariables = true;
  };
  
  # Network
  networking.hostName = "nixos-xx";
  
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  environment.systemPackages = with pkgs; [
		git
    vim 
    wget
  ];
  
  users.users = {
   kefrnik = {
     initialPassword = "aboba";
     isNormalUser = true;
     openssh.authorizedKeys.keys = [];
     extraGroups = ["wheel"];
   };
  };
  
  
  # BLUETOOTH
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
