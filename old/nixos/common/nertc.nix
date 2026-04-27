{
  sops.secrets.nix-netrc = {
    sopsFile = ./secrets.yaml;
    path = "/etc/nix/netrc";
    mode = "0440";
    owner = "root";
    group = "nixbld";
  };
}
