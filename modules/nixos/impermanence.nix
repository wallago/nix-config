{ lib, ... }:
let inherit (lib) mkOption types;
in {
  options.persistencePath = mkOption {
    type = types.str;
    default = "/persist";
    description = "Path to the persistent storage.";
  };
}
