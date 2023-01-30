{ pkgs, ... }:

{
	home.packages = with pkgs; [
		discord
		spotify
		syncthing
		keepassxc
		droidcam
		flameshot
		librsvg
		guff
		evolution
	];

	services.syncthing = {
		enable = true;
		tray = {
			# enable = true;
			package = pkgs.qsyncthingtray;
			command = "qsyncthingtray";
		};
	};

	services.pasystray.enable = true;
}
