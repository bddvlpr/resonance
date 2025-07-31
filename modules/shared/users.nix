{
  lib,
  config,
  self,
  pkgs,
  ...
}:
{
  options.bowl.users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          superuser = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether the user is an administrator or not.";
          };

          groups = lib.mkOption {
            type = with lib.types; listOf str;
            default = [ ];
            description = "Additional groups to grant to the user.";
          };

          shell = lib.mkOption {
            type = lib.types.package;
            default = pkgs.fish;
            description = "Default shell for the user.";
          };
        };
      }
    );
    default = {
      bddvlpr = {
        superuser = true;
      };
    };
    description = "A list of users to create with sensible defaults.";
  };

  config = {
    sops.secrets = lib.mapAttrs' (
      user: _:
      lib.nameValuePair "user-password-${user}" (
        self.lib.mkUserSecret {
          key = "user/password";
          inherit user;
          extraArgs.neededForUsers = true;
        }
      )
    ) config.bowl.users;

    users.users = lib.mapAttrs (
      name: user:
      self.lib.systemTernary pkgs {
        default = {
          inherit (user) shell;
        };

        linux = {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."user-password-${name}".path;
          extraGroups = [
            "audio"
            "video"
            "dialout"
            "networkmanager"
          ]
          ++ (lib.optionals user.superuser [ "wheel" ])
          ++ user.groups;
        };

        darwin = {
          home = "/Users/${name}";
        };
      }
    ) config.bowl.users;
  };
}
