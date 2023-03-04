{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		corepack-shims
		deno
		file
		git-filter-repo
		google-chrome-dev
		jq
		nodejs
	];

	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			bbenoist.qml
			boukichi.git-exclude
			brunnerh.insert-unicode
			denoland.vscode-deno
			marvhen.reflow-markdown
			mvllow.rose-pine
			# sainnhe.everforest
			valentjn.vscode-ltex
		];
		userSettings = {
			"window.menuBarVisibility" = "toggle";

			#"workbench.colorTheme" = "Everforest Light";
			#"everforest.highContrast" = true;
			#"everforest.lightWorkbench" = "high-contrast";
			#"everforest.lightContrast" = "medium";
			"workbench.colorTheme" = "Rosé Pine Dawn";
			"workbench.iconTheme" = "rose-pine-icons";
			"editor.fontLigatures" = true;

			"files.insertFinalNewline" = true;
			"editor.insertSpaces" = false;
			"editor.useTabStops" = true;
			"editor.stickyTabStops" = true;

			"editor.unicodeHighlight.ambiguousCharacters" = false;
			"editor.unicodeHighlight.invisibleCharacters" = false;
		} // {
			"ltex.additionalRules.enablePickyRules" = true;
			"ltex.additionalRules.motherTongue" = "fr";

			"files.associations"."*.md.html" = "markdown";
			"[markdown]" = {
				"editor.rulers" = [ 80 ];
				"editor.insertSpaces" = true;
				"editor.tabSize" = 4;
			};
		};
	};

	/* See https://github.com/nix-community/home-manager/issues/3507 */
	programs.vscode.mutableExtensionsDir = true;
	home.file.".vscode/extensions/extensions.json".text =
		pkgs.vscode-utils.toExtensionJson config.programs.vscode.extensions;

	programs.git = {
		enable = true;
		lfs.enable = true;

		extraConfig = {
			user.name = "Edhebi";
			user.email = "19776499+edhebi@users.noreply.github.com";
			push.autoSetupRemote = true;
			url."ssh://git@".insteadOf = "https://";
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

	programs.bat = {
		enable = true;
		config = {
			map-syntax = [ "*.md.html:Markdown" ];
			theme = "GitHub";
		};
		extraPackages = with pkgs.bat-extras; [ batman batgrep ];
	};

	programs.exa = {
		enable = true;
	};
}
