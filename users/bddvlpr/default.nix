{ pkgs, ... }:
{
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

      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgZVPZ2+cqT1seskNMDRtb8x+W6XkJBl9w8ZkqzkWP8 bddvlpr@kiwi"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBtNqtIZtEaty6EAPwKQj5s0AxUfaJaCrQYeEaWFtqM/ bddvlpr@strawberry"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdRlPLeVFbEwSszVTzYsN08c+k+jBYAzHJPLsKPm6Jg bddvlpr@lychee"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQD+D84uxNORR9bqVYRe5d9rvpyBG/3n7WWOUWLT/oP bddvlpr@pear"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtwlvpvW1/A+c8sHsRG8WXOVIwZIsOPXXpAghR2qvs3 bddvlpr@peach"
      ];

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
      { from = ".config/sops"; }
      { from = ".ssh"; }
      { from = "Desktop"; }
      { from = "Documents"; }
      { from = "Pictures"; }
      { from = "Videos"; }
    ];
  };
}
