{
  self,
  config,
  ...
}: let
  inherit (config.networking) hostName;
in {
  sops.defaultSopsFile = "${self}/systems/${hostName}/secrets.yaml";
}
