{ ... }:
{
  # GnuPG private key agent
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableFishIntegration = true;
  };
}
