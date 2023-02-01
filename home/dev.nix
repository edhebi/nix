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
			bbenoist.qml
			mvllow.rose-pine
			brunnerh.insert-unicode
		];
		userSettings = {
			"window.menuBarVisibility" = "toggle";

			"workbench.colorTheme" = "Rosé Pine Dawn";
			"workbench.iconTheme" = "rose-pine-icons";
			
			"files.insertFinalNewline" = true;
			"editor.insertSpaces" = false;
			"editor.fontLigatures" = true;

			"files.associations"."*.md.html" = "markdown";
		};
	};

	/* See https://github.com/nix-community/home-manager/issues/3507 */
	programs.vscode.mutableExtensionsDir = false;
	home.file.".vscode/extensions/extensions.json".text =
		pkgs.vscode-utils.toExtensionJson config.programs.vscode.extensions;

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
