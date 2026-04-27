{
  disk = import ./disk.nix;
  u2f = import ./u2f.nix;
  keyboard = import ./keyboard.nix;
  wireguad-client = import ./wireguard_client.nix;
  ssh = import ./ssh.nix;
}
