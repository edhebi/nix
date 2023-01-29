# A nixpkgs instance grabbed from the nixpkgs commit in the lock file.
# This is useful to avoid using channels when using legacy nix commands.
let
	lockfile = builtins.fromJSON (builtins.readFile ./flake.lock);
	lock = lockfile.nodes.nixpkgs.locked;
in import (fetchTarball {
	url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
	sha256 = lock.narHash;
})
