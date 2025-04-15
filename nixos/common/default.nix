{
  config,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    ./ssh.nix
    ./nix.nix
    ./boot.nix
    ./sops.nix
    ./grub.nix
    ./home.nix
    ./fish.nix
    ./font.nix
    ./upower.nix
    ./nixpkgs.nix
    ./network.nix
    ./systemd-initrd.nix
    ./optin-persistence.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  # ---

  security.pam.yubico = {
    enable = true;
    id = "31022640";
  };

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  system.stateVersion = "${config.system.nixos.release}";
}
