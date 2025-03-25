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
