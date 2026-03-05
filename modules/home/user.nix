{ lib, config, ... }:
let
  cfg = config.bowl.user;
in
{
  options.bowl.user = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Full name of the user, used in git and other programs.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Email of the user, used in git and other programs.";
    };

    keys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Keys that are allowed to log in to this user.";
    };
  };

  config = lib.mkIf (cfg.keys != [ ]) {
    home.file.".ssh/authorized_keys" = {
      force = true;
      text = lib.concatStringsSep "\n" cfg.keys;
    };
  };
}
