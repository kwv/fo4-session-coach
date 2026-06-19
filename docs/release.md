# Release Process

Releases are built locally (the Papyrus Compiler is Windows-only and cannot run in CI).
GitHub Actions handles zip packaging and Nexus upload after the tag is pushed.

## Steps

### 1. Prepare a release branch

```
git checkout main && git pull
git checkout -b release/vX.Y.Z
```

### 2. Update VERSION

Edit `VERSION` to the new version string:

```
v0.6.0
```

### 3. Build

```
make build
```

This reads `VERSION`, stamps `__VERSION__` in `src/LudoTrace.psc`, compiles the `.pex`,
then restores the source file. The compiled `dist/Data/Scripts/LudoTrace.pex` is updated
in place.

### 4. Commit and open a PR

```
git add VERSION dist/Data/Scripts/LudoTrace.pex
git commit -m "Release vX.Y.Z"
git push -u origin release/vX.Y.Z
```

Open a PR, get it merged to main.

### 5. Tag and release

From main after the PR merges:

```
git checkout main && git pull
make release
```

`make release` reads `VERSION`, creates the tag, and pushes it. GitHub Actions picks up
the tag, zips `dist/`, uploads to Nexus, and updates `CHANGELOG.md`.

### 6. Update Nexus mod page version (manual)

The Nexus Files page changelog is updated automatically. The mod page version badge
(shown on the mod header) has no API endpoint — update it manually in Nexus mod settings.

---

## What each make target does

| Target | What it does |
|--------|-------------|
| `make build` | Stamps version from `VERSION`, compiles `.pex`, restores source |
| `make release` | Reads `VERSION`, tags from main, pushes tag to trigger CI |
| `make run` | Launches the game via `f4se_loader.exe` |

---

## Notes

- The `VERSION` file is the single source of truth for the version string
- `src/LudoTrace.psc` always contains `__VERSION__` in source control — the placeholder
  is only substituted during `make build` and immediately restored
- The compiled `.pex` in `dist/` is committed — it is the release artifact
- Never tag before building — the tag push triggers CI which zips whatever is in `dist/`
