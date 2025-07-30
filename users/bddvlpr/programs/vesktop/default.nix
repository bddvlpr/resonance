{ inputs, ... }@args:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config = import ./settings.nix args;
  };

  bowl.persist.entries = [
    { path = ".config/vesktop"; }
  ];
}
