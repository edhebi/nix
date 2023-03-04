{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableSyntaxHighlighting = true;
		autocd = true;
		dotDir = ".config/zsh/";
		history.path = "\${XDG_STATE_HOME}/zsh/history";
		prezto.enable = true;

		shellAliases = {
			md = "mkdir -p";
			icat = "kitty +kitten icat";
			isvg = "rsvg-convert | icat";
		};

		initExtra = ''
			unsetopt BEEP
		'';
	
		sessionVariables = rec {
			XDG_CONFIG_HOME = "$HOME/.config";
			XDG_CACHE_HOME = "$HOME/.cache";
			XDG_DATA_HOME = "$HOME/.local/share";
			XDG_STATE_HOME = "$HOME/.local/state";

			NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";
			XCOMPOSEFILE = "${XDG_CONFIG_HOME}/X11/xcompose";
			XCOMPOSECACHE ="${XDG_CACHE_HOME}/X11/xcompose";
			GTK2_RC_FILES = "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
			ICEAUTHORITY = "${XDG_CACHE_HOME}/ICEauthority";
			CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv/ComputeCache";
		};

		plugins = [
			{
				name = "zsh-nix-shell";
				file = "nix-shell.plugin.zsh";
				src = pkgs.fetchFromGitHub {
					owner = "chisui";
					repo = "zsh-nix-shell";
					rev = "v0.5.0";
					hash = "sha256-IT3wpfw8zhiNQsrw59lbSWYh0NQ1CUdUtFzRzHlURH0=";
				};
			}
		];
	};

	xdg.enable = true;

	xdg.configFile."npm/npmrc".text = ''
		prefix=''${XDG_DATA_HOME}/npm
		cache=''${XDG_CACHE_HOME}/npm
		init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
	'';
}
