{ pkgs, lib, config, ... }:

let
	mod = "Mod4";
	
	workspaces = [0 1 2 3 4 5 6 7 8 9];
	wid = n: if n == 0 then "10" else toString n;
	eachWorkspace = f: builtins.foldl' lib.mergeAttrs {}
		(map (n: f (toString n) (wid n)) workspaces);
in {
	xsession.windowManager.i3 =  {
		enable = true;
		package = pkgs.i3-rounded;
		config = {
			modifier = mod;
			terminal = "${pkgs.kitty}/bin/kitty";

			keybindings = eachWorkspace (n: id: {
				"${mod}+${n}" = "workspace number ${id}";
				"${mod}+Shift+${n}" = "move container to workspace number ${id}";
			}) // {
				"${mod}+Up" = "focus up";
				"${mod}+Down" = "focus down";
				"${mod}+Left" = "focus left";
				"${mod}+Right" = "focus right";

				"${mod}+Shift+Up" = "move up";
				"${mod}+Shift+Down" = "move down";
				"${mod}+Shift+Left" = "move left";
				"${mod}+Shift+Right" = "move right";

				"${mod}+Control+Left" = "workspace prev";
				"${mod}+Control+Right" = "workspace next";

				"${mod}+Control+Shift+Left" = "move container to workspace prev; workspace prev";
				"${mod}+Control+Shift+Right" = "move container to workspace next; workspace next";

				"${mod}+Shift+q" = "kill";
				"${mod}+Shift+space" = "layout toggle splith splitv stacking tabbed";
				
				"${mod}+l" = "exec loginctl lock-session";
				"${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
				"${mod}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";
				"${mod}+b" = "exec ${pkgs.firefox-devedition-bin}/bin/firefox-devedition";
				"${mod}+p" = "exec ${pkgs.keepassxc}/bin/keepassxc";
				"${mod}+f" = "exec ${pkgs.rofi}/bin/rofi -show filebrowser";
				"${mod}+s" = "exec ${pkgs.flameshot}/bin/flameshot gui";
			};

			bars = [];

			startup = [
				{ command = "i3-msg workspace 1"; notification = false; }
				{ command = "xsetroot -solid '#faf4ed'"; notification = false; }
				{
					command = "${pkgs.feh}/bin/feh --bg-fill --no-fehbg ${./wallpaper.png}";
					notification = false;
				}
				{
					command = "systemctl restart --user polybar";
					always = true;
					notification = false;
				}
			];
		};
		extraConfig = with pkgs.rose-pine.dawn; ''
			for_window [class=".*"] border pixel 3
			gaps inner 12
			gaps outer 3
			smart_gaps on
			smart_borders on

			#                       border  bg      text    indic.  child-border
			client.focused          ${iris} ${base} ${text} ${iris} ${iris}
			client.focused_inactive ${foam} ${base} ${text} ${iris} ${foam}
			client.unfocused        ${base} ${base} ${text} ${iris} ${base}
			client.urgent           ${love} ${base} ${text} ${iris} ${love}
			client.placeholder      ${base} ${base} ${text} ${iris} ${base}
		'';
	};

	home.pointerCursor = {
		package = pkgs.numix-cursor-theme;
		name = "Numix-Cursor-Light";
		gtk.enable = true;
		x11.enable = true;
	};
	
	programs.feh.enable = true;
}
