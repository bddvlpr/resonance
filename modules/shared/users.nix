{
  lib,
  config,
  self,
  pkgs,
  ...
}: let
  inherit (self.lib) mkUserSecret systemTernary;
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
    sops.secrets =
      mapAttrs' (
        user: _:
          nameValuePair "user-password-${user}" (mkUserSecret {
            key = "user/password";
            inherit user;
            extraArgs.neededForUsers = true;
          })
      )
      config.bowl.users;

    users.users = mapAttrs (name: user:
      systemTernary pkgs {
        linux = {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."user-password-${name}".path;
          extraGroups =
            ["audio" "video" "dialout"]
            ++ (optionals user.superuser ["wheel"])
            ++ user.groups;
        };

        darwin = {
          home = "/Users/${name}";
        };
      })
    config.bowl.users;
  };
}
