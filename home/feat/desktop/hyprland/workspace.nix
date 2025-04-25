{ config, lib, ... }:
map (m: "name:${m.workspace},monitor:${m.name}")
(lib.filter (m: m.enabled && m.workspace != null) config.monitors)
