{ pkgs ? (import ../nixpkgs.nix) {} }:

{
	tabler-icons = pkgs.callPackage ./tabler-icons {};
	rose-pine = pkgs.callPackage ./rose-pine {};
}
