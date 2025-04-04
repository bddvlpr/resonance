#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "No hostname supplied"
  exit 1
fi

temp=$(mktemp -d)

mkdir -p "$temp/persist/etc/ssh/"
ssh-keygen -t ed25519 -f "$temp/persist/etc/ssh/ssh_host_ed25519_key" -C "root@$1" -N ""
ssh-keygen -t ecdsa -f "$temp/persist/etc/ssh/ssh_host_ecdsa_key" -C "root@$1" -N ""
ssh-keygen -t rsa -f "$temp/persist/etc/ssh/ssh_host_rsa_key" -C "root@$1" -N ""

echo "Generated keys in $temp"
echo "Add following keys to manifest:"
ssh-to-age < "$temp/persist/etc/ssh/ssh_host_ed25519_key.pub"
