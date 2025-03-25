{
  imports = [
    ./services
    ./hardware-configuration.nix

    ../common/global
    ../common/users/hugo
    ../common/optional/fail2ban.nix
    ../common/optional/tailscale-exit-node.nix
  ];

  networking = {
    hostName = "home";
    useDHCP = true;
  };
}
