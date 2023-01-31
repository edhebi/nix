{
	additions = self: super: import ../pkgs { pkgs = self; };

	modifications = self: super: {
		vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions (
			(import ./vscode-extensions.nix) self super
		);
	};
}
