{pkgs, ...} @ args: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  programs.starship = {
    enable = !isDarwin; # TODO: Currently looks terrible because the osx default terminal is limited.
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = import ./settings.nix args;
  };
}
