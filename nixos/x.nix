{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		firefox-devedition-bin
		kitty
		i3-rounded
		pipewire
	];

	fonts = {
		fonts = with pkgs; [
			jetbrains-mono
			atkinson-hyperlegible
			tabler-icons
		];
		enableDefaultFonts = true;
		fontconfig.defaultFonts = {
			monospace = [ "JetBrains Mono" ];
			sansSerif = [ "Atkinson Hyperlegible" ];
		};
	};

	services.xserver = {
		enable = true;
		autorun = true;
		libinput.enable = true;
		
		displayManager.sddm = {
			enable = true;
			autoNumlock = true;
		};
		
		windowManager.i3.enable = true;
		
		desktopManager.xfce.enable = true;
		desktopManager.xterm.enable = false;
	};

	programs.droidcam.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
}
