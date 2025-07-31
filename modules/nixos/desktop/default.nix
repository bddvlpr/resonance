{ lib, ... }:
{
  imports = [
    ./environments.nix
    ./login.nix
    ./xdg.nix
  ];

  options.bowl.desktop = {
    autoLogin = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether to auto-login the user or not.
          Refrain from using autoLogin if the disk is not password protected!
        '';
      };

      user = lib.mkOption {
        type = lib.types.str;
        description = "The user to auto-login as.";
      };

      package = lib.mkOption {
        type = lib.types.package;
        description = "The environment to load in to.";
      };
    };

    loginManager = lib.mkOption {
      type = lib.types.enum [ "greetd" ];
      default = "greetd";
      description = "Which login manager to use.";
    };
  };

  config = {
    programs.dconf.enable = true;
  };
}
