{
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  environment.persistence."/persist".directories = [
    "/etc/ssh"
  ];

  fileSystems."/etc/ssh".neededForBoot = true;
}
