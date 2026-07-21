{ self, lib, ... }:
let
  inherit (self.lib.ssh) hosts;
  inherit (self.lib.wireguard) wg1;
  wg1Hosts = lib.filterAttrs (name: _: wg1.hosts ? ${name}) hosts;
  mkEntries =
    name: def:
    let
      ip = wg1.hosts.${name}.ip;
      mk =
        suffix: e:
        lib.nameValuePair "${suffix}-wg1" {
          hostname = ip;
          inherit (e) user port;
        };
    in
    if lib.isList def then map (e: mk e.alias e) def else [ (mk name def) ];
in
{
  flake.homeModules.sshWg1 = {
    programs.ssh.settings = lib.listToAttrs (lib.concatLists (lib.mapAttrsToList mkEntries wg1Hosts));
  };
}
