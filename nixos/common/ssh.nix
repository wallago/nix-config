{
  lib,
  outputs,
  config,
  ...
}:
let
  hosts = lib.attrNames outputs.nixosConfigurations;

  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persistent
  hasOptinPersistence = config.environment.persistence ? "/persistent";
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
        path = "${lib.optionalString hasOptinPersistence "/persistent"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh.knownHosts = lib.genAttrs hosts (hostname: {
    publicKeyFile = ../../hosts/${hostname}/ssh_host_ed25519_key.pub;
    extraHostNames =
      # Alias for localhost if it's the same host
      (lib.optional (hostname == config.networking.hostName) "localhost");
  });
}
