{ lib, ... }:
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
  };
}
