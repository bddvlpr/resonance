{ ... }@args:
{
  sops.secrets."spotify/client-id" = { };

  programs.spotify-player = {
    enable = true;

    settings = import ./settings.nix args;
  };

  bowl.persist.entries = [
    { path = ".cache/spotify-player"; }
  ];
}
