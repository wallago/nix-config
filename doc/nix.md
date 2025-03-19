# Nix Pills

https://nixos.org/guides/nix-pills/

## General

- The core of a **Nix** system is the **Nix store**, usually installed under `/nix/store`, and some tools to manipulate the store.
- In **Nix** there is the notion of a **derivation** rather than a package.
- Derivations are stored in the Nix store as follows: `/nix/store/«hash-name»`, where the **hash** uniquely identifies the **derivation**, and the **name** of the **derivation**.
- Everything in the **Nix store** is **immutable**.
- There's no **ldconfig cache**.
  ```sh
  $ ldd `which bash`
  libc.so.6 => /nix/store/94n64qy99ja0vgbkf675nyk39g9b978n-glibc-2.19/lib/libc.so.6 (0x00007f0248cce000)
  ```
- Straight **dependencies** from **derivations to other derivations**.
- Since **Nix derivations** are **immutable**, upgrading a library like glibc means recompiling all applications, because the glibc path to the **Nix store has been hardcoded**.
- With **Nix** you switch to using other software with its own stack of dependencies, but there's no formal notion of upgrade or downgrade when doing so.
- **Nix** lets you compose software at build time with **maximum flexibility**, and with builds being as **reproducible as possible**.

## Advance

- In a **multi-user** installation, such as the one used in **NixOS**, the **store** is owned by **root** and multiple users can install and build software through a **Nix daemon**.
- `/nix/store` can contain not only **directories**, but also **files**.
- **Nix** has a **database** stored under `/nix/var/nix/db`. It is a **sqlite database** that keeps track of the **dependencies between derivations**.\
  You can inspect the **database** by installing **sqlite** via `nix-env -iA sqlite -f '<nixpkgs>'` and then running `sqlite3 /nix/var/nix/db/db.sqlite`.

> [!CAUTION]
> Never change `/nix/store` **manually**.\
> If you do, then it will no longer be in **sync** with the **sqlite db**, unless you really know what you are doing.

- **Nix** is a general and convenient concept for realizing **rollbacks**.
- **Profiles** are used to compose components that are spread among multiple paths under a new unified path.
- **Profiles** are made up of multiple **"generations"**: they are versioned.
- Whenever you change a **profile**, a new **generation** is created.
- **Generations** can be **switched** and **rolled back** atomically, which makes them convenient for managing changes to your system.
  ```sh
  $ ls -l ~/.nix-profile/
  bin -> /nix/store/ig31y9gfpp8pf3szdd7d4sf29zr7igbr-nix-2.1.3/bin
  [...]
  manifest.nix -> /nix/store/q8b5238akq07lj9gfb3qb5ycq4dxxiwm-env-manifest.nix
  [...]
  share -> /nix/store/ig31y9gfpp8pf3szdd7d4sf29zr7igbr-nix-2.1.3/share
  ```
  That `nix-2.1.3` **derivation** in the Nix store is **Nix** itself, with binaries and libraries.
- `~/.nix-profile` itself is a symbolic link to `/nix/var/nix/profiles/default`.
- **Nix expressions** are written in the **Nix language** and used to describe packages and how to build them.
- **Nixpkgs** is the repository containing all of the **expressions**: https://github.com/NixOS/nixpkgs.
- **The channels profile** can be found at `~/.nix-defexpr/channels` who points to `/nix/var/nix/profiles/per-user/nix/channels` which points to `channels-XXX-link` which points to a **Nix store** directory containing the **downloaded Nix expressions**.
- **Channels** are a set of **packages and expressions** available for **download**.
- What `~/.nix-profile/etc/profile.d/nix.sh` really does is simply to add `~/.nix-profile/bin` to `PATH` and `~/.nix-defexpr/channels/nixpkgs` to `NIX_PATH`.
- With **profiles** we're able to **manage multiple generations of a composition of packages**.
- With **channels** we're able to **download binaries from nixos.org**.

## Querying the store

- All of the **environment components** point to the **store**.
- To **query** and **manipulate** the store, there's the `nix-store` command.
- To show the direct **runtime dependencies** of **man**:
  ```sh
  $ which man
  /etc/profiles/per-user/me/bin/man
  $ nix-store -q --references /etc/profiles/per-user/me/bin/man
  /nix/store/cmpyglinc9xl9pr4ymx8akl286ygl64x-glibc-2.40-66
  /nix/store/08j612qggmppcl8h68139s76fw4yb3bj-db-5.3.28
  /nix/store/4bxg01nkr4m3ydgshrgisxvggb23p6x3-libpipeline-1.5.8
  /nix/store/bbljpzvwhh3zrmyppd1ayshpmsakqybz-util-linux-minimal-2.40.4-bin
  /nix/store/ki4if6b0w5bqv8dc5lrjp8xm7wjy9dlf-bash-5.2p37
  /nix/store/g9h265xkvsma74irj4389djs39k96d72-gzip-1.13
  /nix/store/hs0y167zwrihy3g9kk09gypbfi77ka34-groff-1.23.0
  /nix/store/jbl8yvq0hd6w9bxvhzav6p35f3nwa3jh-zstd-1.5.6-bin
  /nix/store/lm6sf6579x7pyd27sv5akj9sac9bwh3i-man-db-2.13.0
  ```
- The `manifest.nix` file contains **metadata** about the **environment**, such as which derivations are installed.
- **The closures** of a **derivation** is a list of **all its dependencies**, **recursively**, including absolutely everything necessary to use that **derivation**.
  ```sh
  $ nix-store -qR /etc/profiles/per-user/me/bin/man
  [...]
  ```
- Copying all those derivations to the **Nix store** of **another machine** makes you able to run `man` out of the box on that **other machine**.
- That's the base of deployment using **Nix**, and you can already foresee the potential when **deploying software in the cloud**.

> [!TIP]
> Tools `nix-copy-closures` or `nix-store --export`.

- A nicer view of the **closure**:
  ```sh
  $ nix-store -q --tree /etc/profiles/per-user/me/bin/man
  [...]
  ```
- Listing installed derivations:
  ```sh
  $ nix-store -q --requisites /run/current-system
  [...]
  ```

## Channels

- The **tool** to manage channels is `nix-channel`.
  ```sh
  $ sudo nix-channel --list
  nixos https://nixos.org/channels/nixos-24.05
  ```
