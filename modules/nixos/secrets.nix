{
  inputs,
  self,
  config,
  ...
}:
let
  inherit (config.networking) hostName;
in
{
  imports = [ inputs.sops-nix.nixosModules.default ];

  sops.defaultSopsFile = "${self}/systems/${hostName}/secrets.yaml";
}
