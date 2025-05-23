{
  config,
  osConfig,
  ...
}: {
  client_id_command = {
    command = "cat";
    args = [config.sops.secrets."spotify/client-id".path];
  };
  playback_window_position = "Bottom";
  device = {
    name = "Spotify Player (${osConfig.networking.hostName})";
    type = "computer";
    volume = 100;
    audio_cache = true;
  };
}
