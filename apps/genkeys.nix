{
  pkgs,
  lib,
  ...
}:
let
  ssh-to-age = lib.getExe pkgs.ssh-to-age;
in
pkgs.writeShellScriptBin "genkeys" ''
  if [ -z "$1" ]; then
    echo "no hostname supplied"
    exit 1
  fi

  temp=$(mktemp -d)

  mkdir -p "$temp/persist/etc/ssh"
  ssh-keygen -t ed25519 -f "$temp/persist/etc/ssh/ssh_host_ed25519_key" -C "root@$1" -N ""
  ssh-keygen -t ecdsa -f "$temp/persist/etc/ssh/ssh_host_ecdsa_key" -C "root@$1" -N ""
  ssh-keygen -t rsa -f "$temp/persist/etc/ssh/ssh_host_rsa_key" -C "root@$1" -N ""

  echo "generated keys in $temp"
  echo "add following key to manifest:"
  ${ssh-to-age} < "$temp/persist/etc/ssh/ssh_host_ed25519_key.pub"
''
