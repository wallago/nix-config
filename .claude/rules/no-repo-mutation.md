# No repo mutation

**Never run a command that changes history, the working copy's identity, or
anything on a remote.** Not with permission, not "just this once", not as the
last step of something I approved. This is not a review gate — it is off.

Specifically off: `commit`, `describe`, `push`, `tag`, `rebase`, `abandon`,
`reset`, `checkout`, `new`, `edit`, `bookmark`, `gh pr create`, `gh release`,
`cargo publish`, and any task-runner recipe that wraps one of those.

## What to do instead

Print the exact command, in a block, and stop. I run it. If a sequence is
needed, print the whole sequence at once — don't hand it to me one line per
turn waiting to see if it worked.

## What is fine

Every read: `status`, `log`, `diff`, `show`, `blame`, `gh pr view`, and the
whole local gate (`check`, `lint`, `test`, `ci`). Run those freely, before and
after a change, without asking.
