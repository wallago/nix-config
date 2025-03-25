# Nix derivations

**Derivations** are the building blocks of a **Nix system**, from a file system view point.

## The derivation function

The **derivation built-in** function is used to create **derivations**.

It takes as input an **attribute set**, the attributes of which specify the `inputs` to the process. \
It `outputs` an attribute set, and produces a store derivation as a side effect of evaluation.

```nix
nix-repl> d = derivation { name = "myname"; builder = "mybuilder"; system = "mysystem"; }
nix-repl> d
«derivation /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv»
```

This create a `.drv` file.

## Digression about `.drv` files

This file is a specification of how to build the derivation, without all the Nix language fuzz.\
It's stored in the **nix store**.

To check in detail a `.drv`, you can use `nix derivation show <path>`, like:

```shell
$ nix derivation show /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv
{
  "/nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv": {
    "outputs": {
      "out": {
        "path": "/nix/store/40s0qmrfb45vlh6610rk29ym318dswdr-myname"
      }
    },
    "inputSrcs": [],
    "inputDrvs": {},
    "platform": "mysystem",
    "builder": "mybuilder",
    "args": [],
    "env": {
      "builder": "mybuilder",
      "name": "myname",
      "out": "/nix/store/40s0qmrfb45vlh6610rk29ym318dswdr-myname",
      "system": "mysystem"
    }
  }
}
```

You can build the **derivation** in `nix repl`, with `:b`:

```nix
nix-repl> d = derivation { name = "myname"; builder = "mybuilder"; system = "mysystem"; }
nix-repl> :b d
[...]
these derivations will be built:
  /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv
building path(s) `/nix/store/40s0qmrfb45vlh6610rk29ym318dswdr-myname'
error: a `mysystem' is required to build `/nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv', but I am a `x86_64-linux'
```

If you wont do that i a `nix repl`, tou can do:

```shell
$ nix-store -r /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-myname.drv
```

## Referring to other derivations

The `outPath` describes the location of the files of that **derivation**.\

```nix
nix-repl> d.outPath
"/nix/store/40s0qmrfb45vlh6610rk29ym318dswdr-myname"
nix-repl> builtins.toString d
"/nix/store/40s0qmrfb45vlh6610rk29ym318dswdr-myname"
```

> [!TIP]
> Nix does the "set to string conversion" as long as there is the outPath attribute:
>
> ```nix
> nix-repl> builtins.toString { outPath = "foo"; }
> "foo"
> nix-repl> builtins.toString { a = "b"; }
> error: cannot coerce a set to a string, at (string):1:1
> ```

## When is the derivation built

**Nix** does not build **derivations** during evaluation of **Nix expressions**.

> [!IMPORTANT]
> During Instantiate/Evaluation time.\
> The Nix expression is parsed, interpreted and finally returns a derivation set.\
> During evaluation, you can refer to other derivations because Nix will create `.drv` files and we will know out paths beforehand.\
> This is achieved with [nix-instantiate](https://nix.dev/manual/nix/2.24/command-ref/nix-instantiate).

> [!IMPORTANT]
> During Realise/Build time.\
> The `.drv` from the derivation set is built, first building `.drv` inputs (build dependencies).\
> This is achieved with `nix-store -r`.

## Using a script as a builder

`builder.sh`:

```sh
declare -xp
echo foo > $out
```

So with the usual trick, we can refer to `bin/bash` and create our **derivation**:

```nix
nix-repl> :l <nixpkgs>
Added 3950 variables.
nix-repl> "${bash}"
"/nix/store/ihmkc7z2wqk3bbipfnlh0yjrlfkkgnv6-bash-4.2-p45"
nix-repl> d = derivation { name = "foo"; builder = "${bash}/bin/bash"; args = [ ./builder.sh ]; system = builtins.currentSystem; }
nix-repl> :b d
[1 built, 0.0 MiB DL]

this derivation produced the following outputs:
  out -> /nix/store/gczb4qrag22harvv693wwnflqy7lx5pb-foo
```

## The builder environment

We can use `nix-store --read-log` to see the logs our builder produced:

```shell
$ nix-store --read-log /nix/store/gczb4qrag22harvv693wwnflqy7lx5pb-foo
[...]
```

## Packaging a simple C program

`simple.c`:

```c
void main() {
    puts("Simple!");
}
```

`simple_builder.sh`:

```sh
export PATH="$coreutils/bin:$gcc/bin"
mkdir $out
gcc -o $out/simple $src
```

- We added two new attributes to the derivation call, `gcc` and `coreutils`.
  - In `gcc = gcc;`, the left is the **derivation set**, and the right is the `gcc` **derivation** from **nixpkgs**.
  - The same applies for `coreutils`.
- We also added the `src` **attribute**, nothing magical --- it's just a name, to which the path `./simple.c` is assigned.
- We then create `$out` as a directory and place the binary inside it.\
  `gcc` is found via the `PATH` environment variable, but it could equivalently be referenced explicitly using `$gcc/bin/gcc`.

```nix
nix-repl> :l <nixpkgs>
nix-repl> simple = derivation { name = "simple"; builder = "${bash}/bin/bash"; args = [ ./simple_builder.sh ]; gcc = gcc; coreutils = coreutils; src = ./simple.c; system = builtins.currentSystem; }
nix-repl> :b simple
this derivation produced the following outputs:

  out -> /nix/store/ni66p4jfqksbmsl616llx3fbs1d232d4-simple
```

> [!TIP]
> Every **attribute** in the set passed to **derivation** will be converted to a `string` and passed to the **builder** as an **environment variable.**\
> This is how the **builder** gains access to `coreutils` and `gcc`.\
> The **derivations** evaluate to their `output` paths, and appending `/bin` to these leads us to their binaries.\
> The same goes for the `src` variable.\
> `$src` is the path to `simple.c` in the nix store.

## Enough of `nix repl`

`simple.nix`:

```nix
let
  pkgs = import <nixpkgs> { };
in
derivation {
  name = "simple";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./simple_builder.sh ];
  inherit (pkgs) gcc coreutils;
  src = ./simple.c;
  system = builtins.currentSystem;
}
```

- `import <nixpkgs> {}` is calling two functions, not one. \
  Reading it as `(import <nixpkgs>) {}` makes this clearer.\
  The value returned by the `nixpkgs` function is a set; more specifically, it's a set of derivations.\
  Calling `import <nixpkgs> {}` into a `let` creates the local variable `pkgs` and brings it into scope.

`nix-build` does two jobs:

- `nix-instantiate`: parse and evaluate `simple.nix` and return the `.drv` file corresponding to the parsed derivation set
- `nix-store -r`: realise the `.drv` file, which actually builds it.

Finally, it creates the symlink.
