{ pkgs ? (import ../nixpkgs.nix) {} }:

{
	rose-pine = pkgs.callPackage ./rose-pine {};
	tabler-icons = pkgs.callPackage ./tabler-icons {};
}
