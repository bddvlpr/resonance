{
  home-manager.users = {
    bddvlpr = {
      bowl = {
        desktop.monitors = [
          {
            name = "HDMI-A-2";
            workspace = 1;

            width = 1920;
            height = 1200;
            refreshRate = 60;

            x = 0;
            scale = 1.0;
          }
          {
            name = "DP-1";
            workspace = 2;

            width = 1920;
            height = 1200;
            refreshRate = 60;

            x = 1920;
            scale = 1.0;
          }
          {
            name = "DP-4";
            workspace = 3;

            width = 3840;
            height = 2160;
            refreshRate = 60;

            x = 3840;
            scale = 2.0;
          }
        ];
      };
    };
  };
}
