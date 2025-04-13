{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./environments.nix
    ./login/greetd.nix
  ];

  options.bowl.desktop = {
    autoLogin = mkOption {
      type = types.bool;
      default = config.bowl.disk.preset == "luks-btrfs";
      description = ''
        Whether to auto-login the user or not.
        Refrain from using autologin if the disk is not password encrypted!
      '';
    };

    loginManager = mkOption {
      type = types.enum ["greetd"];
      default = "greetd";
      description = "Which login manager to use.";
    };
  };
}
