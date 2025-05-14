{
  home-manager.users = {
    bddvlpr = {
      bowl.desktop.monitors = [
        {
          name = "DP-6";
          workspace = 1;

          width = 1920;
          height = 1080;
          refreshRate = 165;

          x = 0;
          scale = 1.0;
        }
        {
          name = "HDMI-A-2";
          workspace = 2;

          width = 3440;
          height = 1440;
          refreshRate = 100;

          x = 1920;
          scale = 1.0;
        }
        {
          name = "DP-4";
          workspace = 3;

          width = 1920;
          height = 1080;
          refreshRate = 75;

          x = 5360;
          scale = 1.0;
        }
      ];
    };
  };
}
