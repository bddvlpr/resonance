{lib}: let
  inherit (lib) isAttrs isList;
in {
  systemTernary = pkgs: {
    default ? null,
    linux ? null,
    darwin ? null,
  }: let
    inherit (pkgs.stdenv) hostPlatform system;

    value =
      if hostPlatform.isLinux
      then linux
      else if hostPlatform.isDarwin
      then darwin
      else throw "No case found for ${system}";
  in
    if isList default
    then default ++ value
    else if isAttrs default
    then default // value
    else value;
}
