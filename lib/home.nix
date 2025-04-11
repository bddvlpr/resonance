{lib, ...}: let
  inherit (lib) any attrNames getAttrFromPath;
in {
  # thank you isabel :sob:
  hasHome = conf: cond: path: let
    list =
      map (
        user: getAttrFromPath (["home-manager" "users" user] ++ path) conf
      )
      (attrNames conf.bowl.users);
  in
    any cond list;
}
