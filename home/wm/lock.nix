{ pkgs, ... }:

let
	colors = pkgs.rose-pine.dawn;

	xrandr  = "${pkgs.xorg.xrandr}/bin/xrandr";
	convert = "${pkgs.imagemagick}/bin/convert";
	lock    = "${pkgs.i3lock-color}/bin/i3lock-color";

	script = pkgs.writeScript "session-lock" ''
		bg=$(mktemp)

		res=$(${xrandr} --current | grep -oP "(?<=current )\d+ x \d+")
		res=''${res// /}

		${convert} -size $res xc:black -quality 11 png24:$bg
		${convert} $bg \
		 	\( "${./wallpaper.png}" -resize $res^ -extent $res \) \
		 	-gravity NorthWest -geometry +0+0 -composite -quality 11 png24:$bg

		blank="#00000000"
		default="${colors.pine}"
		clear="${colors.base}88"
		text="${colors.text}"
		wrong="${colors.love}"
		verif="${colors.iris}"

		${lock} -n -i $bg \
			--insidever-color=$clear --ringver-color=$verif \
			--insidewrong-color=$clear --ringwrong-color=$wrong \
			\
			--inside-color=$clear --ring-color=$default \
			--line-color=$blank --separator-color=$default \
			\
			--verif-color=$text --wrong-color=$text --layout-color=$text \
			\
			--indicator --clock
	''; 
in {
	services.screen-locker = {
		enable = true;
		lockCmd = "${script}";
	};
}
