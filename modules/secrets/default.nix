{ inputs, ... }:
let
  sops_config = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
  };
  hmKeyFile = "/var/lib/secrets/sops/age/keys.txt";
in
{
  flake.nixosModules.secrets = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops = sops_config;
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
