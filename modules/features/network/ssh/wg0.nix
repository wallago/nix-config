{ self, lib, ... }:
let
  inherit (self.lib.ssh) hosts;
  inherit (self.lib.wireguard) wg0;
  wg0Hosts = lib.filterAttrs (name: _: wg0.hosts ? ${name}) hosts;
  mkEntries =
    name: def:
    let
      ip = wg0.hosts.${name}.ip;
      mk =
        suffix: e:
        lib.nameValuePair "${suffix}-wg0" {
          hostname = ip;
          inherit (e) user port;
        };
    in
    if lib.isList def then map (e: mk e.alias e) def else [ (mk name def) ];
in
{
  flake.homeModules.sshWg0 = {
    programs.ssh.settings = lib.listToAttrs (lib.concatLists (lib.mapAttrsToList mkEntries wg0Hosts));
  };
}
