{ inputs, self, ... }:
{
  flake.nixosModules.spongeModule =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.spongeHardware
        inputs.home-manager.nixosModules.default # import official home-manager NixOS module
      ];
      users.users.USERNAME = {
        # create user
        isNormalUser = true;
        shell = pkgs.fish;
      };
      home-manager.users.USERNAME = self.homeModules.USERNAMEModule; # enable home-manager for user

      environment.systemPackages = [
        pkgs.vim
        pkgs.firefox
      ];
    };
}
