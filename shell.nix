{ pkgs ? (import ./nixpkgs.nix) {} , ... }:

{
	default = pkgs.mkShell {
		NIX_CONFIG = "extra-experimental-features = nix-command flakes";
		nativeBuildInputs = with pkgs; [ nix home-manager git ];
	};
}

