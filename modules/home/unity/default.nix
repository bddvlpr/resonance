{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.unity;
in
{
  options.sysc.unity = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Unity.";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        unityhub
        vrc-get
      ];

      file = {
        ".config/unityhub/projectDir.json".text = ''
          {
            "directoryPath": "/home/bddvlpr/Documents/Unity"
          }
        '';

        ".config/unityhub/secondaryInstallPath.json".text = ''
          "/home/bddvlpr/.local/share/unity3d"
        '';
      };

      persistence."/persist/home/bddvlpr".directories = [
        ".config/unityhub"
        ".config/unity3d"
        ".local/share/unity3d"
      ];
    };
  };
}
