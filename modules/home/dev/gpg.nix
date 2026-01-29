{
  lib,
  config,
  ...
}:
let
  cfg = config.bowl.user.gpg;
in
{
  options.bowl.user.gpg = {
    publicKeys = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            source = lib.mkOption {
              type = lib.types.path;
              description = "Where the file is, duh.";
            };
            trust = lib.mkOption {
              type =
                with lib.types;
                nullOr (enum [
                  "unknown"
                  1
                  "never"
                  2
                  "marginal"
                  3
                  "full"
                  4
                  "ultimate"
                  5
                ]);
              default = null;
              apply =
                v:
                if lib.isString v then
                  {
                    unknown = 1;
                    never = 2;
                    marginal = 3;
                    full = 4;
                    ultimate = 5;
                  }
                  .${v}
                else
                  v;
              description = "Trust in key ownership. Read the docs, I ain't typing that here.";
            };
          };
        }
      );
      default = [ ];
      description = "What do you think this is :sob:.";
    };
  };

  config = {
    programs.gpg = {
      enable = true;

      mutableKeys = false;
      mutableTrust = false;

      inherit (cfg) publicKeys;
    };

    bowl.persist.entries = [
      {
        from = ".gnupg";
        mode = "0700";
      }
    ];
  };
}
