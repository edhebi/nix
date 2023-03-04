{ pkgs, buildNpmPackage, fetchFromGitHub, ... }:

buildNpmPackage rec {
	name = "everforest-vscode";
	version = "0.3.0";

	passthru = rec {
		vscodeExtPublisher = "sainnhe";
		vscodeExtName = "everforest";
		vscodeExtUniqueId = "${vscodeExtPublisher}.${vscodeExtName}";
	};

	src = fetchFromGitHub {
		owner = "sainnhe";
		repo = "everforest-vscode";
		rev = "1e6e97e2ef074993f6e0ff6f2d67514431f22067";
		hash = "sha256-kyDYWjUAZdZ4l/ycVPbW1SahHR6uirRbQMa2YIUNLGw=";
	};

	patches = [ ./everforest.patch ];
	npmDepsHash = "sha256-cuEe0AoBJWpzPzgxbb4ydfv0wtRNbS/hGQCRaKeidRU=";

	npmBuildScript = "compile";

	installPhase = let
		suffix = "share/vscode/extensions/${passthru.vscodeExtUniqueId}";
		tmpdir = "/tmp/everforest/vscode";
	in ''
		runHook preInstall
		install -Dm644 -t $out/${suffix} package.json
		cp -r dist $out/${suffix}/dist
		install -d $out/${suffix}/themes
		install -d ${tmpdir}
		for theme in $(ls themes); do
			cp "themes/$theme" ${tmpdir}
			ln -s "${tmpdir}/$theme" "$out/${suffix}/$theme"
		done
		runHook postInstall
	'';
}
