{
  inputs,
  self,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops =
    let
      inherit (config.home) username;
    in
    {
      defaultSopsFile = "${self}/users/${username}/secrets.yaml";
      age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };
}
