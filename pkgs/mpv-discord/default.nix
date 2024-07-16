{
  buildGoModule,
  fetchFromGitHub,
  stdenv,
  lib,
}: let
  name = "mpv-discord";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "tnychn";
    repo = name;
    rev = "v${version}";
    hash = "sha256-Uvm4McZR88s9tsstqLz7O2F3KkqsGlGrDoL8RjgQnVI=";
  };

  core = buildGoModule {
    name = "${name}-core";
    inherit version;
    src = "${src}/mpv-discord";

    vendorHash = "sha256-xe1jyWFQUD+Z4qBAVQ0SBY0gdxmi5XG9t29n3f/WKDs=";
  };
in
  stdenv.mkDerivation rec {
    inherit name version src;

    scriptName = "discord.lua";

    installPhase = ''
      mkdir -p $out/share/mpv/scripts/
      cp -rv $src/scripts/discord.lua $out/share/mpv/scripts/${scriptName}

      substituteInPlace $out/share/mpv/scripts/${scriptName} --replace 'binary_path = ""' 'binary_path = "${core}/bin/mpv-discord"'
    '';

    meta = with lib; {
      description = "A cross-platform Discord Rich Presence integration for mpv with no external dependencies";
      homepage = "https://github.com/tnychn/mpv-discord";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
