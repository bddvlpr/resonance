{ self, ... }:
rec {
  mkSecret =
    {
      key,
      owner ? "root",
      group ? "root",
      mode ? "0400",
      extraArgs ? { },
    }:
    {
      inherit
        key
        owner
        group
        mode
        ;
    }
    // extraArgs;

  mkUserSecret =
    {
      user,
      key,
      owner ? user,
      group ? user,
      mode ? "0400",
      extraArgs ? { },
    }:
    mkSecret {
      inherit
        key
        owner
        group
        mode
        ;
      extraArgs = {
        sopsFile = "${self}/users/${user}/secrets.yaml";
      }
      // extraArgs;
    };
}
