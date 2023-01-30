{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableSyntaxHighlighting = true;
		autocd = true;
		dotDir = ".config/zsh/";
		prezto.enable = true;

		shellAliases = {
			md = "mkdir -p";
			icat = "kitty +kitten icat";
			isvg = "rsvg-convert | icat";
		};

		initExtra = ''
			unsetopt BEEP

			eval "$(${pkgs.nodenv}/bin/nodenv init -)"
			completions="~/.nodenv/completions/nodenv.zsh"
			[ -f $completions ] && source $completions
		'';
	};
}
