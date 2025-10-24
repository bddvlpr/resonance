{
  lib,
  config,
  ...
}:
let
  cfg = config.bowl.user;
in
{
  options.bowl.user.git = {
    defaultBranch = lib.mkOption {
      type = lib.types.str;
      default = "main";
      description = "When creating a new repository, use this value as the new branch name.";
    };
    signing = {
      key = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
        description = ''
          The key to use when signing commits.
          Set to `null` to let git decide.
        '';
      };
      signByDefault = lib.mkOption {
        type = with lib.types; nullOr bool;
        default = null;
        description = "Use signing by default. Only enable if you use gpgsigning, duh.";
      };
    };
  };

  config = {
    programs.git = {
      enable = true;

      inherit (cfg.git) signing;

      settings = {
        user = {
          inherit (cfg) name email;
        };

        init = {
          inherit (cfg.git) defaultBranch;
        };

        push = {
          autoSetupRemote = true;
        };

        alias = {
          l = "log -n 20 --graph --abbrev-commit --pretty=oneline";
          s = "status -s";
          d = "diff";
          dc = "diff --cached";

          tags = "tag -l";
          branches = "branch --all";
          remotes = "remote --verbose";
          contributors = "shortlog --summary --numbered";

          amend = "commit --amend --reuse-message=HEAD";
          credit = "commit --amend -C HEAD --author";
        };

        credential = {
          helper = "store";
        };
      };
    };

    bowl.persist.entries = [
      {
        path = ".git-credentials";
        type = "file";
      }
    ];
  };
}
