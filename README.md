# fieldpro course

Everything you need to run and build **fieldpro**, the field service app from UPEO Academy's
course [ERPNext as a Platform](https://www.upeo.academy/courses/erpnext-as-platform-course),
in one download: both apps, the setup scripts and the start scripts.

| Folder | What it is |
|---|---|
| `fieldpro-frappe/` | The Frappe app on top of ERPNext v16: the backend, its API and the managers' Vue app at `/manage`. Its own repo: [karani-gk/fieldpro-frappe](https://github.com/karani-gk/fieldpro-frappe). |
| `fieldpro-nextjs/` | The Next.js app: the technician app (`/tech`) and the customer portal (`/portal`). Its own repo: [karani-gk/fieldpro-nextjs](https://github.com/karani-gk/fieldpro-nextjs). |
| `setup/` | Four scripts that build the bench, the site and the demo data, in order. |
| `start-backend.sh`, `start-app.sh` | Start the two servers, one terminal each. |
| `fieldpro-bench/` | Made by `setup/01-bench.sh` (not in git): Frappe, ERPNext and the site. |

## Get it

```bash
git clone --recurse-submodules https://github.com/karani-gk/fieldpro-course.git
cd fieldpro-course
```

The two apps are git submodules: each keeps its own history, and the bench runs
`fieldpro-frappe/` directly, so your changes there are the code you see running.

## Run it

You need Ubuntu 22.04 or 24.04 (8 GB RAM), MariaDB, Redis, Python 3.14, Node.js 22.6 or newer,
and `bench` (`pipx install frappe-bench`).

```bash
# Once
./setup/01-bench.sh                    # Frappe 16.23.0 + ERPNext 16.23.1 + fieldpro in fieldpro-bench/
./setup/02-site.sh                     # site fieldpro.localhost (asks for the MariaDB root password)
./setup/03-activate.sh '<access code>' # the code from your course email, then the demo data
./setup/04-app.sh                      # the Next.js app's packages

# Every time, in two terminals
./start-backend.sh                     # Frappe on :8030, socket.io on :9030, workers, scheduler
./start-app.sh                         # Next.js on http://localhost:3030
```

**The access code.** The code is free to read, but nobody can sign in to an installation until it
is activated once with the access code emailed to learners when they enrol in the course. Run
`03-activate.sh` with it, or open http://localhost:8030/activate.

## Sign in

`03-activate.sh` loads a demo company, Baridi Services Ltd. The password for every demo user is
`fieldpro-demo`.

| Who | Where | Sign in |
|---|---|---|
| Technician (Achieng, Otieno, Wanjiru) | http://localhost:3030/tech | `achieng@fieldpro.test` or `0700 100001` (`…002`, `…003`) with the password, or **Use a sign-in code instead** |
| Customer (Wanjiku Clinic and two more) | http://localhost:3030/portal | `clinic@fieldpro.test`, `apartments@fieldpro.test`, `supermarket@fieldpro.test` |
| Manager | http://localhost:8030/manage, or ERPNext Desk at http://localhost:8030/desk/service-job?desk=1 | `manager@fieldpro.test` |
| Administrator | http://127.0.0.1:8030/desk | `Administrator` / `admin` |

Nothing is sent from a local machine: a technician's sign-in code is saved in Desk under
**SMS Log**, which only the Administrator can open. Use `127.0.0.1` for the Administrator so its
sign-in does not replace the manager's on `localhost`.

## Ports

Web 8030, socket.io 9030, Redis 11030 (queue) and 13030 (cache), Next.js 3030. They are chosen so
fieldpro runs beside other benches on the same machine.

## Tests

```bash
cd fieldpro-bench && bench --site fieldpro.localhost run-tests --app fieldpro  # backend
cd fieldpro-nextjs && npm test && npm run typecheck && npm run lint              # frontend
```

## Get the latest code

```bash
git pull
git submodule update --remote --merge   # the newest commits of both apps
```

A submodule starts on a fixed commit, not a branch. Before you commit your own changes in one,
run `git switch main` inside it.
