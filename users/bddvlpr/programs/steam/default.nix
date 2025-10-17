{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (steam.override (prev: {
      extraEnv =
        let
          protonPaths = lib.makeSearchPathOutput "steamcompattool" "" [ proton-ge-bin ];
        in
        {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = protonPaths;
        }
        // (prev.extraEnv or { });
    }))
    steam-run
    protontricks
    gamescope
    mangohud
  ];

  bowl.persist.entries = [
    { path = ".factorio"; }
    { path = ".local/share/Steam"; }
  ];
}
