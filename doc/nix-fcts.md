# Nix functions

Functions help to build reusable components in a big repository like `nixpkgs`.

## Nameless and single parameter

Functions are **anonymous (lambdas)**, and only have a **single parameter**.

```nix
nix-repl> x: x*2
«lambda»
nix-repl> double = x: x*2
nix-repl> double
«lambda»
nix-repl> double 3
6
```

## More than one parameter

- We defined a function that takes the parameter `a`, the body returns another function.
- This other function takes `a` parameter `b` and returns `a*b`.
- Therefore, calling `mul 3` returns this kind of function: `b: 3*b`.
- In turn, we call the returned function with `4`, and get the expected **result**.

```nix
nix-repl> mul = a: (b: a*b)
nix-repl> mul
«lambda»
nix-repl> mul 3
«lambda»
nix-repl> (mul 3) 4
12
nix-repl> mul = a: b: a*b
nix-repl> mul
«lambda»
nix-repl> mul 3
«lambda»
nix-repl> mul 3 4
12
nix-repl> mul (6+7) (8+9)
221
nix-repl> foo = mul 3
nix-repl> foo 4
12
nix-repl> foo 5
15
```

## Argument set

- It is possible to pattern match over a `set` in the parameter.

```nix
nix-repl> mul = s: s.a*s.b
nix-repl> mul { a = 3; b = 4; }
12
nix-repl> mul = { a, b }: a*b
nix-repl> mul { a = 3; b = 4; }
12
nix-repl> mul = { a, b }: a*b
nix-repl> mul { a = 3; b = 4; c = 6; }
error: anonymous function at (string):1:2 called with unexpected argument `c', at (string):1:1
nix-repl> mul { a = 3; }
error: anonymous function at (string):1:2 called without required argument `b', at (string):1:1
```

## Default and variadic attributes

- It is possible to specify default values of attributes in the argument set.
- You can allow passing more attributes (**variadic**) than the expected ones.
- You can give a name to the given set with the **@-pattern**.
- You give a name to the whole parameter with `name@` before the set pattern.

Advantages of using argument sets:

- Named unordered arguments: you don't have to remember the order of the arguments.
- You can pass sets, that adds a whole new layer of flexibility and convenience.

Disadvantages:

- Partial application does not work with argument sets.
- You have to specify the whole attribute set, not part of it.

```nix
nix-repl> mul = { a, b ? 2 }: a*b
nix-repl> mul { a = 3; }
6
nix-repl> mul { a = 3; b = 4; }
12
nix-repl> mul = { a, b, ... }: a*b
nix-repl> mul { a = 3; b = 4; c = 2; }
nix-repl> mul = s@{ a, b, ... }: a*b*s.c
nix-repl> mul { a = 3; b = 4; c = 2; }
24
```

## Imports

- The `import` function is **built-in** and provides a way to parse a `.nix` file.
- You import a file, and it gets parsed as an expression.
- The scope of the imported file does not inherit the scope of the importer.

`test.nix`:

```nix
{ a, b ? 3, trueMsg ? "yes", falseMsg ? "no" }:
if a > b
  then builtins.trace trueMsg true
  else builtins.trace falseMsg false
```

```nix
nix-repl> import ./test.nix { a = 5; trueMsg = "ok"; }
trace: ok
true
```

## Built-ins

Each functions are callable like `builtins.*`.

- `derivation`: To describe a single derivation: a specification for running an executable on precisely defined input files to repeatably produce output files at uniquely determined file system paths.

  Args:

  - An attribute set, with:

    Needed:

    - name: A symbolic name for the derivation.
    - system: The system type on which the `builder` executable is meant to be run.
    - builder: Path to an executable that will perform the build.

    Optional:

    - args: Command-line arguments to be passed to the `builder` executable.
    - outputs: Symbolic outputs of the derivation. \
       Each output name is passed to the `builder` executable as an environment variable with its value set to the corresponding `store path`.
    - ...

  Exemple:

  ```nix
  nix-repl > d = derivation {
          name = "...";
          system = "x86_64-linux";
          builder = "/bin/bash";
          args = [ "-c" "echo hello world > $out" ];
          outputs = [ "lib" "dev" "doc" ];
          ...
      }
  nix-repl > d
  «derivation /nix/store/z3hhlxbckx4g3n9sw91nnvlkjvyw754p-....drv»
  ```

- `div`: To perform a division

  Args:

  - The upper division.
  - The lower division.

  Exemple:

  ```nix
  nix-repl > builtins.div 6 3
  2
  ```

- `trace`: To used for debugging.

  Args:

  - The message to display,
  - The value to return.

  Exemple:

  ```nix
  nix-repl > builtins.trace "msg" true
  true
  ```

- `currentSystem`: To get the name of our system as seen by **nix**.

  Exemple:

  ```nix
  nix-repl > builtins.currentSystem
  "x86_64-linux"
  ```
