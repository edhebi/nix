{ pkgs, stdenv, ... }:

stdenv.mkDerivation {
	name = "corepack-shims";
	buildInputs = [ pkgs.nodejs ];
	phases = [ "installPhase" ];
	installPhase = ''
		mkdir -p $out/bin
		corepack enable --install-directory=$out/bin
	'';
}
