{
  lib,
  outputs,
  config,
  ...
}:
let
  hosts = lib.attrNames outputs.nixosConfigurations;
  startsWith =
    prefix: str: str != null && builtins.substring 0 (builtins.stringLength prefix) str == prefix;

  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at persistent path
  hasOptinPersistence = config.environment.persistence ? "/persist";
in
{
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      LogLevel = "VERBOSE";
    };
    hostKeys = [
      {
        path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 2222 ];

  programs.ssh.knownHosts =
    lib.genAttrs (lib.filter (host: !startsWith "plankton" host) hosts)
      (host: {
        publicKeyFile = ../../hosts/${host}/ssh_host_ed25519_key.pub;
        extraHostNames =
          # Alias for localhost if it's the same host
          (lib.optional (host == config.networking.hostName) "localhost");
      });
}
