{
  lib,
  outputs,
  config,
  ...
}:
let
  hosts = lib.attrNames outputs.nixosConfigurations;
in
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

  programs.ssh = {
    # Each hosts public key
    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../hosts/${hostname}/ssh_host_ed25519_key.pub;
      extraHostNames =
        # Alias for localhost if it's the same host
        (lib.optional (hostname == config.networking.hostName) "localhost");
    });
  };
}
