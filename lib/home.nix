{ lib, ... }:
{
  # thank you isabel :sob:
  hasHome =
    conf: cond: path:
    let
      list = map (
        user:
        lib.getAttrFromPath (
          [
            "home-manager"
            "users"
            user
          ]
          ++ path
        ) conf
      ) (lib.attrNames conf.bowl.users);
    in
    lib.any cond list;
}
