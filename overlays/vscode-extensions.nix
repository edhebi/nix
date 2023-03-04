self: super:

let
	mkExtension = e: self.vscode-utils.extensionFromVscodeMarketplace (e // {
		sha256 = e.hash;
	});
	withKey = drv: { ${drv.vscodeExtPublisher}.${drv.vscodeExtName} = drv; };
	foldExtensions = drvs: with builtins;
		zipAttrsWith (_: foldl' (a: b: a // b) {}) (map withKey drvs);
in foldExtensions
	((with self.pkgs; [
		everforest-vscode
	]) ++ map mkExtension [
		{
			name = "qml";
			publisher = "bbenoist";
			version = "1.0.0";
			hash = "sha256-tphnVlD5LA6Au+WDrLZkAxnMJeTCd3UTyTN1Jelditk=";
		}
		{
			name = "insert-unicode";
			publisher = "brunnerh";
			version = "0.14.0";
			hash = "sha256-8ZWNX1FaC/aBpz5cWAxPL7QZxX68rnbCqYxM/EjYoFI=";
		}
		{
			name = "reflow-markdown";
			publisher = "marvhen";
			version = "2.1.0";
			hash = "sha256-TvxH06M/DwRRL3D+TKQKIb2AyyDmjFyj4JvvWHz+Kfk=";
		}
		{
			name = "git-exclude";
			publisher = "boukichi";
			version = "0.3.1";
			hash = "sha256-fZ7iugIJjkWM34NQEFZ/o/m8SALC+w40CiShyos7n+0=";
		}
	])
