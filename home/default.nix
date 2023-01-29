{ outputs, pkgs, ... }:

{
	imports = [
		./zsh.nix
		./dev.nix
		./others.nix
		./wm
		./nu
	];

	fonts.fontconfig.enable = true;

	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
		];
		config.allowUnfree = true;
		config.allowUnfreePredicate = (_: true);
	};

	home = {
		username = "me";
		homeDirectory = "/home/me/";
		stateVersion = "22.11";
	};

	programs.home-manager.enable = true;
	systemd.user.startServices = "sd-switch";
}
