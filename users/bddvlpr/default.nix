{pkgs, ...}: {
  imports = [
    ./desktop
    ./programs
    ./services
    ./stylix.nix
  ];

  bowl = {
    user = {
      name = "Luna Simons";
      email = "luna@bddvlpr.com";

      git.signing = {
        key = "42EDAE8164B99C3A4B835711AB69B6F3380869A8";
        signByDefault = true;
      };

      gpg.publicKeys = [
        {
          source = pkgs.fetchurl {
            url = "https://keys.openpgp.org/vks/v1/by-fingerprint/42EDAE8164B99C3A4B835711AB69B6F3380869A8";
            hash = "sha256-D0SiN5vr4G0JFOQS4lJWSj3j3wv3epDVlfN9ZiyTZPY=";
          };
          trust = "ultimate";
        }
      ];
    };

    persist.entries = [
      {path = ".config/sops";}
      {path = "Desktop";}
      {path = "Documents";}
      {path = "Pictures";}
      {path = "Videos";}
    ];
  };
}
