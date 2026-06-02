{ lib, ... }:
{
  flake.lib = {
    capitalize = s: lib.toUpper (lib.substring 0 1 s) + lib.substring 1 (-1) s;
  };
}
