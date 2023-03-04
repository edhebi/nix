{ pkgs ? (import ../nixpkgs.nix) {} }:

{
	corepack-shims = pkgs.callPackage ./corepack-shims {};
	everforest-vscode = pkgs.callPackage ./everforest-vscode {};
	rose-pine = pkgs.callPackage ./rose-pine {};
	tabler-icons = pkgs.callPackage ./tabler-icons {};
}
