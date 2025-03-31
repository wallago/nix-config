{ inputs, ... }:
let
  hostname = "shusui";
in
{
  imports = [
    # Includes the Disko module from the disko input in NixOS configuration
    inputs.disko.nixosModules.disko
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./disko-configuration.nix
    (import ../../nixos/common { inherit hostname; })
    ../../nixos/users/yc
  ];

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
      LogLevel = "VERBOSE";
    };
    extraConfig = ''
      # Limits the maximum number of authentication attempts per connection.
      MaxAuthTries 3
      # Limits the number of open sessions per SSH connection.
      MaxSessions 2
      # Determines whether the server sends TCP keepalive messages to ensure the connection is active.
      TCPKeepAlive no
      # Disables TCP forwarding during an SSH session, preventing the server from acting as a proxy.
      AllowTcpForwarding no
      # Disables SSH agent forwarding, which allows the client to forward its authentication agent to the server.
      AllowAgentForwarding no
      # Specifies the maximum number of client alive messages (heartbeats) sent by the server without receiving a response.
      ClientAliveCountMax 2
    '';
  };

  services.xserver.displayManager.gdm = {
    banner = "go fuck your self";
  };
}
