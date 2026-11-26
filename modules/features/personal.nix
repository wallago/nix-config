{ self, ... }:
{
  # What only my own hosts have: their sops keys and the netrc built from
  # them. Kept out of `general` so a host defined in another flake can use
  # `general` without these secrets.
  flake.nixosModules.personal = {
    imports = [
      self.nixosModules.secrets
      self.nixosModules.netrc
    ];
  };

  flake.homeModules.personal =
    { config, ... }:
    {
      imports = [ self.homeModules.secrets ];

      sops.gnupg.home = "/home/${config.preferences.user.name}/.gnupg";
    };
}
