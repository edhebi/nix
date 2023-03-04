{ pkgs, lib, stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
	pname = "tabler-icons";
	version = "2.1.2";

	meta = with lib; {
		description = "Tabler Icons";
		homepage = "https://tabler-icons.io/";
		license = licenses.mit;
		platform = platforms.all;
	};

	src = fetchFromGitHub {
		owner = "tabler";
		repo = "tabler-icons";
		rev = "v${version}";
		hash = "sha256-wJMNG45EVA8dh7osLQTn4MJTiYEdcct6ghjaALr+Iuc=";
	};

	installPhase = let
		fontFile = "${src}/packages/icons-webfont/fonts/tabler-icons.ttf";
	in ''
		install -Dm644 -t $out/share/fonts/truetype/ ${fontFile}
	'';

	passthru.char = let
		scssFile = "${src}/packages/icons-webfont/tabler-icons.scss";
		re = ''^\$ti-icon-([a-z0-9-]+): unicode\('([a-f0-9]+)'\);$/"\1": "\\u\2"'';
		escape = lib.strings.escape ["$" "\\" "\""];
		parse = pkgs.runCommandLocal "parse-scss" { "in" = scssFile; } ''
			mkdir $out
			echo "{" > $out/icons.json
			sed -nE "s/${escape re}/p" "$in" | paste -sd "," >> $out/icons.json
			echo "}" >> $out/icons.json
		'';
	in builtins.fromJSON (builtins.readFile "${parse}/icons.json");
}
