{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  name = "geist-mono-nerd-font";
  version = "3.2.1";

  src = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/GeistMono.zip";
    hash = "sha256-hiFc7y/gRvzCdZKTL85ctWyXVmR0nZnzaFSHpj8PoeE=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.otf -t $out/share/fonts/opentype

    runHook postInsatll
  '';

  meta = with lib; {
    description = "Font family created by Vercel in collaboration with Basement Studio";
    homepage = "https://vercel.com/font";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
