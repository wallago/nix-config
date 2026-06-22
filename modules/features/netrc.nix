{
  flake.nixosModules.netrc = {
    sops.secrets.netrc = {
      sopsFile = ../secrets/netrc.yaml;
      path = "/etc/nix/netrc";
      mode = "0440";
      owner = "root";
      group = "nixbld";
    };

    nix.settings.netrc-file = "/etc/nix/netrc";
  };
}
