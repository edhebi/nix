{ pkgs, lib, ... }:

{
	home.packages = [ pkgs.playerctl ];
	services.playerctld.enable = true;

	services.polybar = {
		enable = true;
		package = pkgs.polybarFull;
		script = "polybar main &";

		settings = let 
			colors = pkgs.rose-pine.dawn;
			i = pkgs.tabler-icons.char;
			colored = text: foreground: { inherit text foreground; };

			spotifyScript = let
				playerctl = "${pkgs.playerctl}/bin/playerctl --player spotify";
				fmt = "{{ artist }} — {{ title }}";

				join = x: xs: toString (lib.intersperse x xs);
				playing = join "&&" (map (s: ''[ "$status" != "${s}" ]'') [
					"Stopped" "No player is running"
				]);
			in pkgs.writeScriptBin "polybar-spotify" ''
				status=$(${playerctl} status 2>/dev/null)
				code=$?


				if [ $code = 0 ] && ${playing}; then
					icon="%{F${colors.foam}}${i.music}%{F-}"
					text=$(${playerctl} metadata --format "${fmt}")
					echo " | $icon $text"
				else
					echo ""
				fi
			'';
		in {
			"bar/main" = {
				width = "100%";
				height = 34;
				padding = 2;
				
				background = colors.base;
				foreground = colors.text;
				
				font = [
					"JetBrains Mono:size=10;3"
					"JetBrains Mono:size=10:style=Bold;3"
					"tabler\\-icons:size=16;4"
				];

				modules.left = "i3 spotify";
				modules.center = "date";
				modules.right = "";
				tray.position = "right";

				enable-ipc = true;
				cursor-click = "pointer";
				locale = "fr_FR.UTF-8";
			};
			"module/i3" = {
				type = "internal/i3";
				format.prefix = colored i.device-desktop colors.pine;
				label.focused = { font = 2; };
				label.unfocused = { foreground = colors.muted; };
			};
			"module/date" = {
				type = "internal/date";
				date = "%A %d %B %Y";
				time = "%Hh%M";
				label = "%date% à %time%";
				format.prefix = colored "${i.clock} " colors.love;
			};
			"module/spotify" = {
				type = "custom/script";
				exec = "${spotifyScript}/bin/polybar-spotify";
			};
		};
	};
}
