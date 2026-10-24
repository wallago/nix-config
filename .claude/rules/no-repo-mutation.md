# No repo mutation

**Never run a command that changes history, the working copy's identity, or
anything on a remote.** Not with permission, not "just this once", not as the
last step of something I approved. This is not a review gate — it is off.

Specifically off: `commit`, `describe`, `push`, `tag`, `rebase`, `abandon`,
`reset`, `checkout`, `new`, `edit`, `bookmark`, `gh pr create`, `gh release`,
`cargo publish`, and any task-runner recipe that wraps one of those.
# No repo mutation

**Never run a command that changes history, the working copy's identity, or
anything on a remote.** Not with permission, not "just this once", not as the
last step of something I approved. This is not a review gate — it is off.

Specifically off: `commit`, `describe`, `push`, `tag`, `rebase`, `abandon`,
`reset`, `checkout`, `new`, `edit`, `bookmark`, `gh pr create`, `gh release`,
`cargo publish`, and any task-runner recipe that wraps one of those.

The one exception is below. Nothing else opens it up.

## Exception: your own `claude/*` branches

Only on a branch whose name starts with `claude/`, you may:

- create that branch from any existing branch,
- commit to it (Conventional Commits, as usual),
- push it — fast-forward only,
- open a pull request from it into any branch, and update that PR's
  title and body.

Still off, even there:

- force-push, `rebase`, `reset`, amending, or any other history rewrite of a
  commit you've already pushed,
- pushing to, or committing on, any branch not named `claude/*`,
- merging, approving, or closing a PR; tags and releases,
- deleting a branch.

The exception doesn't skip propose-before-writing: file changes still need my
go before they land in a commit.

## What to do instead

Print the exact command, in a block, and stop. I run it. If a sequence is
needed, print the whole sequence at once — don't hand it to me one line per
turn waiting to see if it worked.

## What is fine

Every read: `status`, `log`, `diff`, `show`, `blame`, `gh pr view`, and the
whole local gate (`check`, `lint`, `test`, `ci`). Run those freely, before and
after a change, without asking.
