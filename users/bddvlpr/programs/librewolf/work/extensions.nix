{ firefox-addons, ... }:
{
  force = true;
  packages = with firefox-addons; [
    bitwarden
    ghostery
    privacy-badger
    sponsorblock
    ublock-origin
  ];
}
