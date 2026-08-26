# List all commands
default:
    @{{ just_executable() }} --list

# ── Variables ─────────────────────────────────────────────────

host := `hostname`
flake := "."

# ── Dev ───────────────────────────────────────────────────────

# Check if the code is buildable (dry mode)
[group('dev')]
check:
    nix flake check --no-build --print-build-logs --all-systems

# Update every flake input
[group('dev')]
update:
    nix flake update

# Show what disk space is currently occupied by the store
[group('dev')]
size:
    nix path-info -Sh /run/current-system

# Show options available for given package
[group('dev')]
option OPT='':
    manix {{ OPT }}

# ── Build ─────────────────────────────────────────────────────

# Evaluate a host's config without building (fast feedback)
[group('build')]
eval HOST=host:
    nix eval --raw {{ flake }}#nixosConfigurations.{{ HOST }}.config.system.build.toplevel.drvPath

# Build a host's system closure (no activation)
[confirm]
[group('build')]
build HOST=host:
    nh os build {{ flake }} --hostname {{ HOST }}

# Show what would change without building
[group('build')]
diff HOST=host:
    nh os build {{ flake }} --hostname {{ HOST }} --dry

# Render network topology diagrams into ./docs
[group('build')]
topology:
    nix build .#topology.x86_64-linux.config.output
    @cp ./result/network.svg ./docs/network.svg
    @cp ./result/main.svg ./docs/topology.svg

# Build a vm for a host to test it
[group('build')]
build-vm HOST=host:
    nh os build-vm --with-bootloader {{ flake }} --hostname {{ HOST }}

# Build an ISO host and boot it in a QEMU VM (UEFI). Usage: just run-iso
[group('build')]
run-iso HOST='provisionIso':
    nix build {{ flake }}#nixosConfigurations.{{ HOST }}.config.system.build.isoImage
    nix shell nixpkgs#qemu --command qemu-system-x86_64 \
        -enable-kvm -m 4G -smp 2 \
        -bios "$(nix build --print-out-paths nixpkgs#OVMF.fd)/FV/OVMF.fd" \
        -cdrom result/iso/*.iso

# Build the ISO for HOST and burn it to a USB key (interactive device picker)
[group('build')]
boot-key-iso HOST='provisionIso':
    nix build {{ flake }}#nixosConfigurations.{{ HOST }}.config.system.build.isoImage
    nix shell nixpkgs#caligula --command caligula burn result/iso/*.iso

# ── Apply ─────────────────────────────────────────────────────

# Switch the current machine
[confirm]
[group('apply')]
switch HOST=host:
    nh os switch {{ flake }} --hostname {{ HOST }}

# Switch + bump generation but only on next boot
[confirm]
[group('apply')]
boot HOST=host:
    nh os boot {{ flake }} --hostname {{ HOST }}

# Test config without making it the boot default
[confirm]
[group('apply')]
test HOST=host:
    nh os test {{ flake }} --hostname {{ HOST }}

# ── Security ──────────────────────────────────────────────────

# Verify if secure boot is well installed
[group('security')]
secure-boot-check:
    sudo sbctl verify

# Status of secure boot
[group('security')]
secure-boot-status:
    sbctl status

# ── Secrets ───────────────────────────────────────────────────

# Edit a secrets file. Usage: just secret coral
[group('secret')]
secret FILE:
    sops modules/secrets/{{ FILE }}.yaml

# Re-encrypt all secrets after changing recipients in .sops.yaml
[group('secret')]
secrets-rotate:
    find modules/secrets -name '*.yaml' -exec sops updatekeys {} \;

# ── Garbage collection ────────────────────────────────────────

# Collect unreferenced store paths (light, no root, keeps generations)
[group('gc')]
gc:
    nix store gc

# Prune old generations (keep last 5 + last 7 days) then gc + optimise
[group('gc')]
gc-deep:
    nh clean all --keep 5 --keep-since 7d --optimise

# Preview what gc-deep would remove
[group('gc')]
gc-dry:
    nh clean all --dry

# ── Inspection ────────────────────────────────────────────────

# Show all hosts defined by the flake
[group('inspect')]
hosts:
    @nix eval --json {{ flake }}#nixosConfigurations --apply 'builtins.attrNames' | jq -r '.[]'

# Show flake metadata
[group('inspect')]
info:
    nix flake metadata

# Show why a path is in the closure of a host. Usage: just why coral firefox
[group('inspect')]
why HOST PKG:
    nix why-depends {{ flake }}#nixosConfigurations.{{ HOST }}.config.system.build.toplevel nixpkgs#{{ PKG }}

# ── Release ───────────────────────────────────────────────────

# Verify commit messages follow Conventional Commits
[group('release')]
commits:
    committed -vv HEAD

# Regenerate CHANGELOG.md from git history
[group('release')]
changelog:
    git-cliff -o CHANGELOG.md

# Cut & publish a release: bump version, changelog, commit, tag, push. Usage: just publish 0.2.0
[confirm("This will tag and push a release to origin. Continue?")]
[group('release')]
publish VERSION:
    @test -z "$(jj diff --name-only)" || (echo "✗ working copy has uncommitted changes — commit or abandon them first" && exit 1)
    @echo "▶ regenerate changelog"
    git-cliff --tag v{{ VERSION }} -o CHANGELOG.md
    @echo "▶ record release commit"
    jj commit -m "chore(release): v{{ VERSION }}"
    @echo "▶ advance main bookmark"
    jj bookmark set main -r @-
    @echo "▶ tag release commit"
    git tag -a v{{ VERSION }} -m "v{{ VERSION }}" "$(jj log -r @- --no-graph -T commit_id)"
    @echo "▶ push bookmark + tag"
    jj git push --bookmark main
    git push origin v{{ VERSION }}
    @echo "✅ published v{{ VERSION }}"

# ── CI ────────────────────────────────────────────────────────

# Mirror the full CI pipeline locally. Run before pushing.
[group('ci')]
ci:
    @echo "▶ commit format"
    committed -vv HEAD
    @echo "▶ markdown links"
    lychee -v *.md
    @echo "▶ typos"
    typos
    @echo "▶ statix"
    statix check .
    @echo "▶ deadnix"
    deadnix --fail .
    @echo "▶ format check"
    nix fmt -- --ci .
    @echo "▶ flake check"
    nix flake check --print-build-logs --all-systems
    @echo "✅ CI mirror passed"

# # Switch a remote machine over SSH
# # Usage: just switch-remote coral
# switch-remote HOST:
#     nh os switch {{flake}} \
#       --hostname {{HOST}} \
#       --target-host root@{{HOST}} \
#       --build-host root@{{HOST}}
#

# # Claude monitor token
# claude-usage:
#     nix run nixpkgs#claude-monitor
#
# # to rm
#
# # Install NixOS on a remote host using nixos-anywhere, seeding the sops age key
install flake:
    #!/usr/bin/env bash
    set -euo pipefail

    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT

    ssh_dir="$tmp/persist/etc/ssh"
    install -d -m 0755 $ssh_dir
    ssh-keygen -t ed25519 -N "" -C "root@{{ flake }}" \
      -f "$ssh_dir/ssh_host_ed25519_key"
    chmod 600 "$ssh_dir/ssh_host_ed25519_key"
    pub="$ssh_dir/ssh_host_ed25519_key.pub"

    echo
    echo "SSH pubkey:"
    cat "$pub"
    echo
    echo "Age pubkey (add to .sops.yaml):"
    nix shell nixpkgs#ssh-to-age -c ssh-to-age < "$pub"
    echo

    read -rp "Update .sops.yaml + run 'just secrets-rotate', then press Enter to install... "

    nix run github:nix-community/nixos-anywhere -- \
      --flake ".#{{ flake }}" \
      --extra-files "$tmp" \
      --ssh-port 2222 \
      --target-host "root@10.200.0.254"
