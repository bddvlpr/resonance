{
  lib,
  config,
  ...
}:
let
  inherit (lib) isString mkOption types;

  cfg = config.bowl.user.gpg;
in
{
  options.bowl.user.gpg = {
    publicKeys = mkOption {
      type =
        with types;
        listOf (submodule {
          options = {
            source = mkOption {
              type = path;
              description = "Where the file is, duh.";
            };
            trust = mkOption {
              type = nullOr (
                types.enum [
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
                ]
              );
              default = null;
              apply =
                v:
                if isString v then
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
        });
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
  };
}
