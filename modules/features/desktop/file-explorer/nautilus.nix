{
  flake.nixosModules.nautilus = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ nautilus ];
    services.gvfs.enable = true; # trash, mounts, smb/sftp
    programs.dconf.enable = true; # otherwise it forgets every setting
  };
}
