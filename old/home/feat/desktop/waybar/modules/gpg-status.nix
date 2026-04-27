{ mkScriptJson, mkScript, pkgs, config, lib, ... }:
let gpgCmds = import ../../../cli/gpg-commands.nix { inherit pkgs config lib; };
in {
  format = "{icon}";
  format-icons = {
    locked = "󰌾";
    unlocked = "󰿆";
  };
  return-type = "json";
  tooltip = false;
  interval = 3;
  exec = mkScriptJson {
    script = ''
      if ${gpgCmds.isUnlocked}; then
        status="unlocked"
        tooltip="GPG is unlocked"
      else
        status="locked"
        tooltip="GPG is locked"
      fi
    '';
    alt = "$status";
    tooltip = "$tooltip";
  };
  on-click = mkScript {
    script =
      "if ${gpgCmds.isUnlocked}; then ${gpgCmds.lock}; else ${gpgCmds.unlock}; fi";
  };
}

