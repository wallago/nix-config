
# Nix

The dev shell is the environment. Tooling comes from the flake — don't assume
anything is on the bare system, and use `nix run nixpkgs#<tool>` for one-offs.


`.envrc` is `use flake`, so direnv loads the shell on `cd`. `.direnv/` is
gitignored and holds nixpkgs sources — exclude it from any repo-wide file scan.


Nix sources get `statix check` and `deadnix`; format with `nixfmt`.
`nix flake check` is the real verification — a change that only `nix build`s
isn't checked.

<!-- TODO — what this flake actually exposes: packages, dev shells, NixOS or
     home-manager modules, and which systems it builds for. -->

## Lockfiles Are Their Own Change

`flake.lock` is not a file you edit. It changes as a side effect of a
dependency change, and that makes it a separate commit from the code — never
bundled into a feature diff.

