{ self, lib, ... }:
let
  inherit (self.lib.networks) wg1;

  user = "wallago";
  port = 2222;
  overrides = {
    provision-iso.user = "root";
    "4849".user = "labcar";
  };
  # hosts that already have a wg0 entry get a -wg1 alias
  onWg0 = [
    "coral"
    "squid"
    "sponge"
  ];

  mkHost = name: host: {
    name = if lib.elem name onWg0 then "${name}-wg1" else name;
    value = {
      hostname = host.ip;
      inherit port user;
    }
    // (overrides.${name} or { });
  };
in
{
  flake.homeModules.sshWg1 = {
    programs.ssh.settings = lib.mapAttrs' mkHost wg1.hosts;
  };
}
