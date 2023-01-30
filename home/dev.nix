{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		file
		nodejs
		corepack-shims
		google-chrome-dev
	];

	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			mvllow.rose-pine
		];
		mutableExtensionsDir = true;
		userSettings = {
			"window.menuBarVisibility" = "toggle";

			"workbench.colorTheme" = "Rosé Pine Dawn";
			"workbench.iconTheme" = "rose-pine-icons";
			
			"files.insertFinalNewline" = true;
			"editor.insertSpaces" = false;
			"editor.fontLigatures" = true;
		};
	};
	home.file.".vscode/extensions/extensions.json".text = let
		extensionDir = "${config.home.homeDirectory}/.vscode/extensions/";
		extensionPath = drv: "${extensionDir}${drv.vscodeExtUniqueId}";
		extensionEntry = drv: rec {
			identifier.id = drv.vscodeExtUniqueId;
			version = drv.version;
			location = {
				"$mid" = 1;
				fsPath = extensionPath drv;
				path = location.fsPath;
				scheme = "file";
			};
		};
	in builtins.toJSON (map extensionEntry config.programs.vscode.extensions);

	programs.git = {
		enable = true;
		lfs.enable = true;

		extraConfig = {
			user.name = "Edhebi";
			user.email = "19776499+edhebi@users.noreply.github.com";
			push.autoSetupRemote = true;
		};

		aliases = {
			recommit = "commit --amend --no-edit";
		};
	};

	programs.ssh.enable = true;

	programs.kitty = {
		enable = true;
		font = { name = "JetBrains Mono"; size = 12; };
		theme = "Rosé Pine Dawn";
		settings = {
			window_padding_width = 5;
			enable_audio_bell = false;
			confirm_os_window_close = -2;
		};
	};

	
}
