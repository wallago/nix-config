{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
      LogLevel = "VERBOSE";
    };
  };

}
