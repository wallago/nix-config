{ lib, ... }:
let inherit (lib) mkOption types;
in {
  options.persistPath = mkOption {
    type = types.str;
    default = "/persist";
    description = "Path to the persistent storage.";
  };
}
