{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) filter getExe;

  monitorsFor = bar: filter (m: m.bar == bar) config.bowl.desktop.monitors;

  commonArgs = {
    layer = "top";
    position = "top";

    clock = {
      format = "{:%a %d %b %I:%M %p}";
      tooltip-format = "{calendar}";
    };

    pulseaudio = {
      format = "vol {volume}%";
      format-muted = "vol mute";
      on-click = "${getExe pkgs.pamixer} -t";
    };

    network = {
      format = "eth {ifname}";
      format-wifi = "wifi {signalStrength}%";
      format-disconnected = "no network";
      tooltip-format = ''
        {ifname}
        {ipaddr}/{cidr}
        {gwaddr} {netmask}'';
      tooltip-format-wifi = ''
        {ifname}
        {ipaddr}/{cidr}
        {gwaddr} {netmask}
        {essid} {signalStrength}%'';
      tooltip-format-disconnected = "not connected";
    };

    cpu = {
      format = "cpu {usage}%";
    };

    memory = {
      format = "mem {percentage}%";
    };

    battery = {
      format = "bat {capacity}%";
    };

    "hyprland/workspaces" = {
      format = "{id}";
    };
  };
in {
  programs.waybar = {
    style = builtins.readFile ./style.css;

    settings = {
      bigBar =
        commonArgs
        // {
          output = builtins.map (m: m.name) (monitorsFor "big");

          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["cpu" "memory" "pulseaudio" "network" "battery"];
        };
      tinyBar =
        commonArgs
        // {
          output = builtins.map (m: m.name) (monitorsFor "tiny");

          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = [];
        };
    };
  };

  stylix.targets.waybar.addCss = false;
}
