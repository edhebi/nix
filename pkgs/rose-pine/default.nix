{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation {
	pname = "rose-pine";
	version = "0.0.1";

	src = fetchFromGitHub {
		owner = "rose-pine";
		repo = "palette";
		rev = "59b3d7a1f55ba0a27f96caf28dc2ac62e8a610e0";
		sha256 = "1nf895jf7dbrxarvdp3q6hj9p7jgyx8m43snac6rnn7vcmyar3za";
	};

	# so, it turns out I'm too lazy to parse the js/css files.
	passthru.main = {
		base = "#191724";
		surface = "#1f1d2e";
		overlay = "#26233a";
		muted = "#6e6a86";
		subtle = "#908caa";
		text = "#e0def4";
		love = "#eb6f92";
		gold = "#f6c177";
		rose = "#ebbcba";
		pine = "#31748f";
		foam = "#9ccfd8";
		iris = "#c4a7e7";
		highlight.low = "#21202e";
		highlight.med = "#403d52";
		highlight.high = "#524f67";
	};
	passthru.moon = {
		base = "#232136";
		surface = "#2a273f";
		overlay = "#393552";
		muted = "#6e6a86";
		subtle = "#908caa";
		text = "#e0def4";
		love = "#eb6f92";
		gold = "#f6c177";
		rose = "#ea9a97";
		pine = "#3e8fb0";
		foam = "#9ccfd8";
		iris = "#c4a7e7";
		highlight.low = "#2a283e";
		highlight.med = "#44415a";
		highlight.high = "#56526e";
	};
	passthru.dawn = {
		base = "#faf4ed";
		surface = "#fffaf3";
		overlay = "#f2e9e1";
		muted = "#9893a5";
		subtle = "#797593";
		text = "#575279";
		love = "#b4637a";
		gold = "#ea9d34";
		rose = "#d7827e";
		pine = "#286983";
		foam = "#56949f";
		iris = "#907aa9";
		highlight.low = "#f4ede8";
		highlight.med = "#dfdad9";
		highlight.high = "#cecacd";
	};
}
