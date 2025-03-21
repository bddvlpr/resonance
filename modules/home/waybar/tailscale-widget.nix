{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) getExe;

  colors = config.lib.stylix.colors.withHashtag;
  jq = getExe pkgs.jq;
  notify-send = getExe pkgs.libnotify;
  tailscale = getExe pkgs.tailscale;
in
{
  exec = pkgs.writeShellScriptBin "tailscale-widget-exec" ''
    status=$(curl --silent --fail --unix-socket /var/run/tailscale/tailscaled.sock http://local-tailscaled.sock/localapi/v0/status)

    if [ $? != 0 ]; then
      echo "<span color='${colors.base0B}'>󰱟</span>"
      exit 0
    fi

    if [ "$(echo $status | ${jq} --raw-output .BackendState)" = "Stopped" ]; then
      echo "<span color='${colors.base0B}'>󰲝</span>"
      exit 0
    fi

    exit_node="$(echo $status | ${jq} --raw-output '.Peer[] | select(.ExitNode) | .HostName')"

    if [ -n "$exit_node" ]; then
      echo "<span color='${colors.base0B}'>󰛳 </span>$exit_node"
    else
      echo "<span color='${colors.base0B}'>󰛳</span>"
    fi
    exit 0
  '';

  on-click = pkgs.writeShellScriptBin "tailscale-widget-on-click" ''
    operator=$(whoami)

    status=$(curl --silent --fail --unix-socket /var/run/tailscale/tailscaled.sock http://local-tailscaled.sock/localapi/v0/status)
    if [ $? != 0 ]; then
      ${notify-send} "Failed to connect to Tailscale."
      exit 0
    fi


    if [ "$(echo $status | ${jq} --raw-output .BackendState)" = "Stopped" ]; then
      ${notify-send} "Connecting to Tailscale."
      ${tailscale} up --operator=$operator
    else
      ${notify-send} "Disconnecting from Tailscale."
      ${tailscale} down
    fi

  '';
}
