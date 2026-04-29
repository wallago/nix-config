# List all commands
default:
    @{{just_executable()}} --list

# ── Variables ─────────────────────────────────────────────────
# Override at invocation time, e.g. `just build sponge`
host    := `hostname`
flake   := "."

# ── Dev workflow ──────────────────────────────────────────────
# Enter a dev shell (formatters, sops, etc.)
shell:
    nix develop

# Format every nix file in the repo
fmt:
    nix fmt

# Show what `nix flake check` would do without running it
check-dry:
    nix flake check --no-build --print-build-logs

# Mirror full CI locally
check: fmt
    nix flake check --print-build-logs --all-systems
    @echo "✅ All checks passed"

# ── Build ─────────────────────────────────────────────────────
# Evaluate a host's config without building (fast feedback)
eval HOST=host:
    nix eval --raw {{flake}}#nixosConfigurations.{{HOST}}.config.system.build.toplevel.drvPath

# Build a host's system closure (no activation)
build HOST=host:
    nixos-rebuild build --flake {{flake}}#{{HOST}}

# Show what would change without building
diff HOST=host:
    nixos-rebuild dry-activate --flake {{flake}}#{{HOST}}

# ── Apply ─────────────────────────────────────────────────────
# Switch the current machine (asks for sudo)
switch HOST=host:
    sudo nixos-rebuild switch --flake {{flake}}#{{HOST}}

# Switch + bump generation but only on next boot
boot HOST=host:
    sudo nixos-rebuild boot --flake {{flake}}#{{HOST}}

# Test config without making it the boot default
test HOST=host:
    sudo nixos-rebuild test --flake {{flake}}#{{HOST}}

# Switch a remote machine over SSH
# Usage: just switch-remote coral
switch-remote HOST:
    nixos-rebuild switch \
      --flake {{flake}}#{{HOST}} \
      --target-host root@{{HOST}} \
      --build-host root@{{HOST}} \
      --use-substitutes

# ── VMs ───────────────────────────────────────────────────────
# Build a QEMU VM image of a host (graphical)
vm HOST=host:
    nixos-rebuild build-vm --flake {{flake}}#{{HOST}}
    @echo "▶ run with: ./result/bin/run-nixos-vm"

# Build + launch a VM in one step
vm-run HOST=host: (vm HOST)
    ./result/bin/run-nixos-vm

# ── Inputs & updates ──────────────────────────────────────────
# Update every flake input
update:
    nix flake update

# Update a single input. Usage: just update-input nixpkgs
update-input INPUT:
    nix flake lock --update-input {{INPUT}}

# Show what would update (no changes)
update-dry:
    nix flake lock --recreate-lock-file --dry-run 2>&1 | head -50

# Refresh the flake.lock without changing inputs
relock:
    nix flake lock

# ── Secrets (sops-nix) ────────────────────────────────────────
# Edit a secrets file. Usage: just secret coral
secret FILE:
    sops modules/secrets/{{FILE}}.yaml

# Re-encrypt all secrets after changing recipients in .sops.yaml
secrets-rotate:
    find modules/secrets -name '*.yaml' -exec sops updatekeys {} \;

# ── Garbage collection ────────────────────────────────────────
# Clean dev artifacts: ./result symlinks
clean:
    find . -maxdepth 3 -type l -name 'result*' -delete

# Run nix store gc
gc:
    nix store gc

# Aggressive: delete generations older than 14 days, then GC
gc-deep:
    sudo nix-collect-garbage --delete-older-than 14d
    sudo nix store optimise

# Show what disk space is currently occupied by the store
size:
    nix path-info -Sh /run/current-system

# ── Inspection ────────────────────────────────────────────────
# Show all hosts defined by the flake
hosts:
    @nix eval --json {{flake}}#nixosConfigurations --apply 'builtins.attrNames' | jq -r '.[]'

# List packages exposed for the current system
packages:
    @nix flake show --json 2>/dev/null | jq -r '.packages | to_entries[] | .key as $sys | .value | keys[] | "\($sys)\t\(.)"' | column -t

# Show flake metadata
info:
    nix flake metadata

# Show why a path is in the closure of a host
# Usage: just why coral firefox
why HOST PKG:
    nix why-depends {{flake}}#nixosConfigurations.{{HOST}}.config.system.build.toplevel \
      nixpkgs#{{PKG}}

# ── Repo hygiene ──────────────────────────────────────────────
# Spell-check the repo
typos:
    nix run nixpkgs#typos

# Check links in markdown
links:
    nix run nixpkgs#lychee -- '**/*.md'

# Verify dead nix code
deadnix:
    nix run nixpkgs#deadnix -- -f .

# Statix linter for nix
statix:
    nix run nixpkgs#statix -- check .
