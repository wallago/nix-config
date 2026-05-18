{ inputs, ... }:
let
  sops_config = {
    defaultSopsFormat = "yaml";
  };
  hmKeyFile = "/var/lib/secrets/sops/age/keys.txt";
in
{
  flake.nixosModules.secrets = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops = sops_config // {
      age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.homeModules.secrets =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];
      sops = sops_config // {
        age.keyFile = hmKeyFile;
      };
      home.sessionVariables.SOPS_AGE_KEY_FILE = hmKeyFile;
      home.packages = [ pkgs.sops ];
    };
}
