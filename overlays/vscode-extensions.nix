self: super:

let
	marketplace = self.vscode-utils.extensionFromVscodeMarketplace;
in {
	bbenoist.qml = marketplace {
		name = "qml";
		publisher = "bbenoist";
		version = "1.0.0";
		sha256 = "sha256-tphnVlD5LA6Au+WDrLZkAxnMJeTCd3UTyTN1Jelditk=";
	};
	brunnerh.insert-unicode = marketplace {
		name = "insert-unicode";
		publisher = "brunnerh";
		version = "0.14.0";
		sha256 = "sha256-8ZWNX1FaC/aBpz5cWAxPL7QZxX68rnbCqYxM/EjYoFI=";
	};
}
