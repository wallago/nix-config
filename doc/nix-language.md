# Nix Language

The **Nix language** is used to write expressions that produce **derivations**.\
The `nix-build` tool is used to **build derivations** from an **expression**.

> [!IMPORTANT]
> In **Nix**, everything is an **expression**, there are **no statements**.
> This is common in **functional languages**.

> [!IMPORTANT]
> Values in **Nix** are **immutable**.

## Nix repl

`nix repl` is a simple command line tool for playing with the **Nix language**.\
**Nix** supports basic arithmetic operations: `+`, `-`, `*` and `/`.

```sh
nix-repl> 1+3
4

nix-repl> 7-4
3

nix-repl> 3\*2
6
nix-repl> 6/ 3
2
nix-repl> builtins.div 6 3
2
```

Other operators are `||`, `&&` and `!` for booleans, and relational operators such as `!=`, `==`, `<`, `>`, `<=`, `>=`.

## Value types

- integer
- floating point
- string
- path
- boolean
- null
- lists
- sets
- functions

These types are enough to build an **operating system**.

**Nix** is **strongly typed**, but it's **not statically typed**.\
 That is, you cannot mix strings and integers, you must first do the conversion.

## Identifier

- `-` is allowed in identifiers.

## Strings

- Strings are enclosed by `"` or `''`.
- `'` enclosing is not supported.
- It's possible to interpolate whole **Nix expressions** inside strings with the `${...}` syntax and only that syntax.

```sh
nix-repl> "foo"
"foo"
nix-repl> ''foo''
"foo"
nix-repl> 'foo'
error: syntax error, unexpected invalid token
       at «string»:1:1:
            1| 'foo'
             | ^
nix-repl> foo = "strval"
nix-repl> "$foo"
"$foo"
nix-repl> "${foo}"
"strval"
nix-repl> "${2+3}"
error: cannot coerce an integer to a string, at (string):1:2
```

## Lists

- Lists are a sequence of expressions delimited by space (not comma):
- Lists are immutable.
- Adding or removing elements from a list is possible, but will return a new list.

```nix
nix-repl> [ 2 "foo" true (2+3) ]
[ 2 "foo" true 5 ]
```

## Attribute sets

- An attribute set is an association between string keys and **Nix values**.
- Keys can only be strings.
- When writing attribute sets you can also use unquoted identifiers as keys.
- You can use strings to address keys which aren't valid identifiers.
- Inside an attribute set you cannot normally refer to elements of the same attribute set.
- To do so, use recursive attribute sets.

```nix
nix-repl> s = { foo = "bar"; a-b = "baz"; "123" = "num"; }
nix-repl> s
{ "123" = "num"; a-b = "baz"; foo = "bar"; }
nix-repl> s.a-b
"baz"
nix-repl> s."123"
"num"
nix-repl> { a = 3; b = a+4; }
error: undefined variable `a' at (string):1:10
nix-repl> rec { a = 3; b = a+4; }
{ a = 3; b = 7; }
```

## If expressions

- You can't have only the `then` branch, you must specify also the `else` branch, because an expression must have a value in all cases.

```nix
nix-repl> a = 3
nix-repl> b = 4
nix-repl> if a > b then "yes" else "no"
"no"
```

## Let expressions

- The syntax is: first assign variables, then `in`, then an expression which can use the defined variables.
- The value of the whole `let` expression will be the value of the expression after the `in`.
- You cannot assign twice to the same variable.
- However, you can shadow outer variables.
- You cannot refer to variables in a let expression outside of it.
- You can refer to variables in the let expression when assigning variables, like with recursive attribute sets.

```nix
nix-repl> let a = "foo"; in a
"foo"
nix-repl> let a = 3; b = 4; in a + b
7
nix-repl> let a = 3; in let b = 4; in a + b
7
nix-repl> let a = 3; a = 8; in a
error: attribute `a' at (string):1:12 already defined at (string):1:5
nix-repl> let a = 3; in let a = 8; in a
8
nix-repl> let a = (let c = 3; in c); in c
error: undefined variable `c' at (string):1:31
nix-repl> let a = 4; b = a + 5; in b
9
```

## `With` expression

- It takes an attribute set and includes symbols from it in the scope of the inner expression.
- Only valid identifiers from the keys of the set will be included.
- If a symbol exists in the outer scope and would also be introduced by the with, it will not be shadowed.
- You can however still refer to the attribute set.

```nix
nix-repl> longName = { a = 3; b = 4; }
nix-repl> longName.a + longName.b
7
nix-repl> with longName; a + b
7
nix-repl> let a = 10; in with longName; a + b
14
nix-repl> let a = 10; in with longName; longName.a + b
7
```

## Laziness

- Nix evaluates expressions only when needed.
- This is a great feature when working with pack
- Since `a` is not needed, there's no error about division by zero, because the expression is not in need to be evaluated.
- That's why we can have all the packages defined on demand, yet have access to specific packages very quickly.

```nix
nix-repl> let a = builtins.div 4 0; b = 6; in b
6
```
