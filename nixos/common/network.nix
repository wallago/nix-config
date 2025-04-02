{ hostname, ... }:
{
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = false;
  };
}
