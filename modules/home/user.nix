{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.bowl.user = {
    name = mkOption {
      type = types.str;
      description = "Full name of the user, used in git and other programs.";
    };
    email = mkOption {
      type = types.str;
      description = "Email of the user, used in git and other programs.";
    };
  };
}
