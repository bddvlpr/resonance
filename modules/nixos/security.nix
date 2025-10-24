{
  lib,
  self,
  config,
  ...
}:
let
  cfg = config.bowl.fingerprint;
in
{
  options.bowl.fingerprint = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable fingerprint authentication users.";
    };
  };
  config = lib.mkMerge [
    {
      security = {
        sudo = {
          enable = true;
          wheelNeedsPassword = false;
        };
        pki.certificates = [
          ''
            -----BEGIN CERTIFICATE-----
            MIIBfTCCASOgAwIBAgIQFAoZ327VQqpkPO6kjQgSEDAKBggqhkjOPQQDAjAdMRsw
            GQYDVQQDExJTY2FuYmllIEJWIFJvb3QgQ0EwHhcNMjUxMDIxMTIwMjUyWhcNMzUx
            MDE5MTIwMjUyWjAdMRswGQYDVQQDExJTY2FuYmllIEJWIFJvb3QgQ0EwWTATBgcq
            hkjOPQIBBggqhkjOPQMBBwNCAASHhpNxya9i6TYPE5kEBYzAPOKUT2iiETqZJawX
            DnOzIUjV5nHvZtlA6Ke9pePA7yq1pQTezrbNZo+CYMU0hJGyo0UwQzAOBgNVHQ8B
            Af8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQU8WlJpmgNlfNW
            1BpPJgkc5xHD+ckwCgYIKoZIzj0EAwIDSAAwRQIhAOrgtj5yI3QYy69yzDCYa+f+
            lmpNDNxtOUvutw8+IkuJAiB52K1TLh8QqR6xpj3rNvICCKe05DJ7eo6PpuQjR+wZ
            Sw==
            -----END CERTIFICATE-----
          ''
        ];
        polkit.enable = true;
        pam.services = {
          hyprlock = lib.mkIf (self.lib.hasHome config (envs: lib.elem "hyprland" envs) [
            "bowl"
            "desktop"
            "environments"
          ]) { };
          swaylock = lib.mkIf (self.lib.hasHome config (envs: lib.elem "sway" envs) [
            "bowl"
            "desktop"
            "environments"
          ]) { };
        };
      };
    }
    (lib.mkIf cfg.enable {
      services.fprintd.enable = true;

      bowl.persist.entries = [
        { path = "/var/lib/fprint"; }
      ];
    })
  ];
}
