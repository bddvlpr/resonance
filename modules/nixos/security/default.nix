{
  security = {
    pam = {
      services.swaylock.fprintAuth = false;
      loginLimits = [
        {
          domain = "*";
          item = "nofile";
          type = "-";
          value = "524288";
        }
      ];
    };
  };
}
