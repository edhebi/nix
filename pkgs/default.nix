{ pkgs ? (import ../nixpkgs.nix) {} }:

{
	corepack-shims = pkgs.callPackage ./corepack-shims {};
	rose-pine = pkgs.callPackage ./rose-pine {};
	tabler-icons = pkgs.callPackage ./tabler-icons {};
}
