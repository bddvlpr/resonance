{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf osConfig.bowl.entertainment.vr.enable {
    xdg.configFile."openvr/openvrpaths.vrpath" = {
      force = true;
      text = builtins.toJSON {
        config = [ "~/.local/share/Steam/config" ];
        external_drivers = null;
        jsonid = "vrpathreg";
        log = [ "~/.local/share/Steam/logs" ];
        runtime = [ "${pkgs.xrizer}/lib/xrizer" ];
        version = 1;
      };
    };
  };
}
