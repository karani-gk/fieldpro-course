# fieldpro-course

The one download for learners: fieldpro-frappe and fieldpro-nextjs as git submodules, plus the
setup and start scripts. The general guide in `~/projects/CLAUDE.md` applies.

- **Why submodules, not copied code:** `bench get-app` installs an app only from a repo root (a
  subfolder is refused with `InvalidGitRepositoryError`). `setup/01-bench.sh` uses
  `bench get-app --soft-link`, so the bench runs `fieldpro-frappe/` itself.
- **After pushing either app, bump this repo:** `git submodule update --remote`, commit the two
  submodule paths, push. A fresh clone gets the pinned commits, not the apps' latest.
- **Never rename this repo to `fieldpro`:** that name redirects to fieldpro-frappe (its old name).
- **Test a change** by copying the repo to a scratch folder and running `setup/01` to `04`, the
  start scripts and `run-tests` there. Ports 8030/9030/11030/13030/3030 must be free.
- The recording script and other teaching files stay in `~/projects/teaching`, not here.
