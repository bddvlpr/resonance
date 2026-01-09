{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ mpv-discord ];
    config.ytdl-format = "bestvideo+bestaudio";
  };
}
