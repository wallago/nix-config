{

  flake.nixosModules.userWallago =
    { pkgs, ... }:
    {
      users.users.wallago = {
        isNormalUser = true;
        description = "wallago";
        extraGroups = [
          "wheel"
          "networkmanager"
          "video"
          "audio"
        ];
        shell = pkgs.bash;
      };
    };

  flake.homeModules.wallago = {
    home = {
      username = "wallago";
      homeDirectory = "/home/wallago";
    };
  };
}
