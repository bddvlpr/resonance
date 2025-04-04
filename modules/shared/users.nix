{
  lib,
  config,
  ...
}: let
  inherit (lib) mapAttrs mapAttrs' mkOption nameValuePair optionals types;
in {
  options.bowl.users = mkOption {
    type = with types;
      attrsOf (submodule {
        options = {
          superuser = mkOption {
            type = types.bool;
            default = false;
            description = "Whether the user is an administrator or not.";
          };

          groups = mkOption {
            type = with types; listOf str;
            default = [];
            description = "Additional groups to grant to the user.";
          };
        };
      });
    default = {bddvlpr = {superuser = true;};};
    description = "A list of users to create with sensible defaults.";
  };

  config = {
    sops.secrets = mapAttrs' (name: _:
      nameValuePair "users/${name}/password" {
        neededForUsers = true;
      })
    config.bowl.users;

    users.users =
      mapAttrs (name: user: {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."users/${name}/password".path;
        extraGroups =
          ["audio" "video" "dialout"]
          ++ (optionals user.superuser ["wheel"])
          ++ user.groups;
      })
      config.bowl.users;
  };
}
