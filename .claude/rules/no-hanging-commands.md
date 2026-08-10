# Don't run what won't exit

Never run a command that takes over the terminal, waits for input, or runs
until killed. That includes the app itself (`just run`, `cargo run`), watchers
(`bacon`, anything `--watch`), servers, pagers, and any REPL.

Print the command and ask me to run it. I'll paste back what I see.

Long-but-finite is fine — `just ci`, `nix flake check`, a full test run. Slow
isn't the problem; not returning is.
