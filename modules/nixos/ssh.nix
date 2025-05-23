{
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  bowl.persist.entries = [
    {path = "/etc/ssh";}
  ];

  fileSystems."/etc/ssh".neededForBoot = true;
}
