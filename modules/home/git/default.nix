{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "Luna Simons";
    userEmail = "luna@bddvlpr.com";

    signing = {
      key = "42EDAE8164B99C3A4B835711AB69B6F3380869A8";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "libsecret";
    };
  };
}
