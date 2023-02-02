{ lib, pkgs, inputs, outputs, config, ... }:

{
	imports = [
		./hardware-configuration.nix
		./locale.nix
		./x.nix
	];

	environment.systemPackages = with pkgs; [
		unzip
	];

	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
		];
		config.allowUnfree = true;
	};

	nix = {
		registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
		nixPath = lib.mapAttrsToList
			(key: value: "${key}=${value.to.path}")
			config.nix.registry;
		settings = {
			experimental-features = "nix-command flakes";
			auto-optimise-store = true;
		};
		package = pkgs.nixUnstable;
		gc = {
			automatic = true;
			dates = "weekly";
		};
	};

	networking = {
		hostName = "wrex";
		networkmanager.enable = true;
	};

	programs.ssh.startAgent = true;

	users.users.me = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" "video" "audio" "network" ];

		packages = [ pkgs.home-manager ];
	};
	
	environment.pathsToLink = [ "/share/zsh/" ];

	system.stateVersion = "22.11";
}
