{ firefox-addons, ... }:
{
  force = true;
  packages = with firefox-addons; [
    bitwarden
    ghostery
    privacy-badger
    return-youtube-dislikes
    sponsorblock
    ublock-origin
    unpaywall
  ];
}
