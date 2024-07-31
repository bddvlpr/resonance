{
  appimageTools,
  fetchurl,
}:
appimageTools.wrapType2 rec {
  name = "cura5";
  version = "5.7.2";
  src = fetchurl {
    url = "https://github.com/Ultimaker/Cura/releases/download/${version}-RC2/UltiMaker-Cura-${version}-linux-X64.AppImage";
    hash = "sha256-XlTcCmIqcfTg8fxM2KDik66qjIKktWet+94lFIJWopY=";
  };
}
