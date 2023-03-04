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
		slack
		spotify
	];

	services.pasystray.enable = true;
}
 