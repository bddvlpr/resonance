{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) makeSearchPathOutput;
in {
  home = {
    packages = with pkgs; [
      (steam.override (prev: {
        extraEnv = let
          protonPaths =
            makeSearchPathOutput "steamcompattool" "" [proton-ge-bin];
        in
          {
            STEAM_EXTRA_COMPAT_TOOLS_PATHS = protonPaths;
          }
          // (prev.extraEnv or {});
      }))
      steam-run
      protontricks
      gamescope
      mangohud
    ];

    persistence."/persist/home/bddvlpr" = {
      allowOther = true;
      directories = [
        ".factorio"
        ".local/share/Steam"
      ];
    };
  };
}
