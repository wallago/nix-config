{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSponge
    ];
  };

  flake.nixosModules.hostSponge = {
    imports = [
      # self.nixosModules.base
      self.nixosModules.general

      self.nixosModules.nvidia

      # self.nixosModules.desktop

      # self.nixosModules.impermanence

      # self.nixosModules.discord
      # self.nixosModules.gimp
      # self.nixosModules.telegram
      # self.nixosModules.youtube-music

      # self.nixosModules.gaming
      # self.nixosModules.vr
      # self.nixosModules.powersave

      # disko
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.hostSponge
    ];
    # users.users.USERNAME = {
    #   # create user
    #   isNormalUser = true;
    #   shell = pkgs.fish;
    # };
    # home-manager.users.USERNAME = self.homeModules.USERNAMEModule; # enable home-manager for user

    # environment.systemPackages = [
    #   pkgs.vim
    #   pkgs.firefox
    # ];
  };
}
