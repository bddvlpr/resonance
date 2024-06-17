{
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf osConfig.sysc.aagl.enable {
    home.persistence."/persist/home/bddvlpr".directories = [
      ".local/share/honkers-railway-launcher"
    ];
  };
}
