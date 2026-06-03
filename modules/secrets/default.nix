{ inputs, ... }:
{
  flake.nixosModules.secrets =
    { hostName, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      sops = {
        defaultSopsFormat = "yaml";
        defaultSopsFile = ./${hostName}.yaml;
        age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
      };
    };

  flake.homeModules.secrets = {
    home.persistence."/persist/".directories = [
      {
        directory = ".gnupg";
        mode = "0700";
      }
    ];
  };
}
