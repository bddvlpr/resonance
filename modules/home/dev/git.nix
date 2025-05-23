{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;

  cfg = config.bowl.user;
in {
  options.bowl.user.git = {
    defaultBranch = mkOption {
      type = types.str;
      default = "main";
      description = "When creating a new repository, use this value as the new branch name.";
    };
    signing = {
      key = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          The key to use when signing commits.
          Set to `null` to let git decide.
        '';
      };
      signByDefault = mkOption {
        type = with types; nullOr bool;
        default = null;
        description = "Use signing by default. Only enable if you use gpgsigning, duh.";
      };
    };
  };

  config = {
    programs.git = {
      enable = true;

      userName = cfg.name;
      userEmail = cfg.email;
      inherit (cfg.git) signing;

      aliases = {
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

      extraConfig = {
        init = {inherit (cfg.git) defaultBranch;};
        push.autoSetupRemote = true;
        credential.helper = "store";
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
