{
	description = "Edhebi's dotfiles";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		hardware.url = "github:nixos/nixos-hardware";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... } @ inputs: let
		inherit (self) outputs;
		systems = [ "x86_64-linux" ];
		eachSystem = nixpkgs.lib.genAttrs systems;
	in {
		packages = eachSystem (system: import ./pkgs {
			pkgs = nixpkgs.legacyPackagnes.${system};
		});
		devShells = eachSystem (system: import ./shell.nix {
			pkgs = nixpkgs.legacyPackages.${system};
		});

		overlays = import ./overlays;
		nixosModules = import ./modules/nixos;
		homeManagerModules = import ./modules/home-manager;

		nixosConfigurations = {
			wrex = inputs.nixpkgs.lib.nixosSystem {
 				specialArgs = { inherit inputs outputs; };
				modules = [ ./nixos/configuration.nix ];
			};
		};

		homeConfigurations = {
			"me@wrex" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit inputs outputs; };
				modules = [ ./home ];
			};
		};
	};
}

