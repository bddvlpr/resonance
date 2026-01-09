{
  home-manager.users = {
    bddvlpr = {
      bowl = {
        desktop.monitors = [
          {
            name = "HDMI-A-1";
            workspace = 1;
            bar = "tiny";

            width = 1920;
            height = 1200;
            refreshRate = 60;

            x = 0;
            scale = 1.0;
          }
          {
            name = "DP-1";
            workspace = 2;
            bar = "tiny";

            width = 1920;
            height = 1200;
            refreshRate = 60;

            x = 1920;
            scale = 1.0;
          }
          {
            name = "HDMI-A-2";
            workspace = 3;

            width = 2560;
            height = 1440;
            refreshRate = 120;

            x = 3840;
            scale = 1.0;
          }
        ];
      };
    };
  };
}
