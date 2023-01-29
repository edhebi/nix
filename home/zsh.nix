{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableSyntaxHighlighting = true;
		autocd = true;
		dotDir = ".config/zsh/";
		initExtra = ''
			unsetopt BEEP
		'';
		prezto = {
			enable = true;
		};
	};
}
