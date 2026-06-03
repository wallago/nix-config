{ inputs, self, ... }:
{
  flake.nixosConfigurations.coral = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "coral";
      inherit self;
    };
    modules = [
      self.nixosModules.configCoral
      self.nixosModules.hardwareCoral
    ];
  };

  flake.nixosModules.configCoral =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsCoral

        self.nixosModules.intel
        self.nixosModules.wireguardServer
        self.nixosModules.miniflux
        self.nixosModules.nginxReverseProxy
        self.nixosModules.attic
        self.nixosModules.githubRunners

        self.nixosModules.preferencesMinifluxCoral

        self.nixosModules.diskoCoral
      ];

      preferences.user = {
        name = "wallago";
        authorizedSshKeys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKNSN5OYPTbebZXjLOBFLXnMUkBAU6wrpaN25cExo9o3g+79s4wHAR78IaCRBkC+Mwca/PHt1AbTmcaV3jcey9UdhjDITzjkf8d3Wupn3JvuxVHNivvbD9cz0uB4dYeiuGhfpw5/N9l1OzNRK5lClK5PbZBLGxVC0cdoeYD7+1b0nEM+Aeym8l7DxnGBD7n+2WjNd62O0+HF52l0yq3VyAH8YT37NubEMSL5r6ytLvN76/auOsrouz2lHslu/5i3eeIAvijdLK9jFR5BiCxV9r99SAjIeh5FOV3XWu7drEdyjmRkVo3+DfPXwiY8Q5Nce8sP2cVURoAiMP4Cpu+G0B openpgp:0x7770C68F"
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjnObQ6bnKXp0gDRwDXADrd3flYlC6wrjA2AKaruZZksee2eDNadT8Hy1IUM9m40T54xkLj7PnN5hhF1wgFl+5Xx+YCQqsrifH0KZwJToEwEVV8GeYCcwAb8zxzynRkzlK4lXQpzaHhUah4fGbXwmR/zNzIkgtJq/7npteCsewmG8vl7UGgTbRBbK2iNTd4GjM9pfF3ljdwBdNBerBahP2IoMumwSqeuYsBtXzyIcPc22AWYZmcqpsjaKb7WJ6IrMYwklZKuybz70izT9Y5STv8FxiE5SLruKv+9yvQ0xKJ1urqdcuG+xAEUlnEBCAlfZuPntEknlLchCkhFUgkFE1 openpgp:0xD4DED3E3"
        ];
      };

      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general
        ];

        preferences.user = {
          name = userName;
        };
      };
    };
}
