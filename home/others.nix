{ pkgs, ... }:

{
	home.packages = with pkgs; [
		discord
		droidcam
		evolution
		flameshot
		guff
		keepassxc
		librsvg
		pavucontrol
		spotify
		syncthing
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
