# FO4 LudoTrace — Project Context

## What we're building
A Fallout 4 mod that writes a JSON character snapshot after each play session.
The snapshot is pasted into Claude.ai (no API key required) for coaching feedback.

Coaching feel — not a tracker, not a cheat tool:
- "You have a ghoul-slaying legendary but keep fighting ghouls with your pistol"
- "Your Sanctuary water farm is 3x more efficient than your Castle one"
- "You're level 38 with INT 7 and haven't taken Gun Nut past rank 1"

## Who it's for
- First playthrough, sandbox style, not rushing main quest or faction choices
- Wants to enjoy the world more deeply, not complete it faster

Target: community Nexus release. Design for any playstyle, any character.

## Repo
```
fallout4/    ← source of truth
  src/LudoTrace.psc            ← main script
  stubs/Hydra/Events.psc          ← minimal compilation stub (see Compiler notes)
  dist/Data/Scripts/LudoTrace.pex
  dist/Data/Hydra/ScriptFunctions/LudoTrace.json
  Makefile                        ← build/run from WSL (make build, make run)
  tools/compile.bat               ← build + deploy (called by Makefile or double-click)
  tools/run.bat                   ← launches f4se_loader.exe (called by Makefile)
  tools/paths.local.bat           ← gitignored, machine-specific paths
  tools/paths.example.bat
  docs/coaching_prompt.md         ← the Claude.ai prompt that ships with the mod
  referenceIds.tsv                ← Fallout 4 form IDs (perks, ammo, weapons, materials, consumables, weapon mods)
```

## Paths
All machine-specific paths live in `tools/paths.local.bat` (gitignored). Variables:
- `%GAME%` — Fallout 4 game folder
- `%CK%` — Creation Kit / compiler folder
- `%MY_GAMES%` — `Documents\My Games\Fallout4` (user-specific)

Derived paths:
- Compiler: `%CK%\Papyrus Compiler\PapyrusCompiler.exe`
- Snapshot output: `%GAME%\LudoTrace_Snapshot.json`
- Session events log: `%GAME%\LudoTrace_Events.jsonl`

## Log paths
- F4SE + Hydra logs: `%MY_GAMES%\F4SE\`
  - `Hydra.log` — Script Function Runner errors, event registration failures
- Papyrus logs (once enabled): `%MY_GAMES%\Logs\Script\`
- Fallout4Custom.ini: `%MY_GAMES%\Fallout4Custom.ini`

To enable Papyrus logging:
```ini
[Papyrus]
bEnableLogging=1
bEnableTrace=1
bLoadDebugInformation=1
```

## Build process
From WSL: `make build` (compile + deploy) or `make run` (launch game) or `make build run`.
From Windows: double-click `tools/compile.bat`. It:
1. Copies `src/LudoTrace.psc` into the game's `Source\User\` (staging — see Compiler notes)
2. Compiles with import path: `stubs\` → `game Source\User\` → `game Source\`
3. Outputs `LudoTrace.pex` to `dist/Data/Scripts/`
4. Deploys `dist/Data/` into the game's `Data/` folder
5. Removes the staged source file

Console test: `cgf "LudoTrace.WriteSessionStart"` (close console first to see HUD notification)
Quick quit: `qqq`

## Compiler notes
- Papyrus Compiler v2.8.0.4 — does NOT support struct arrays (`string[]`, `Var[]`, `int[]` as struct fields)
- `stubs/Hydra/Events.psc` is our minimal compilation stub — all `*Args` structs that contained array fields replaced with `int iEmptyStruct = 0`. The Params structs (callback parameter types) are kept verbatim. Hydra's real `.pex` handles runtime; stub is compile-time only.
- **Compiler quirk — import path staging**: The compiler derives script names from the common ancestor of all import paths. Two sibling directories under the same parent both being import paths causes name mangling (e.g. `src:LudoTrace` instead of `LudoTrace`). Solution: only `stubs\` is the repo-local import root; `LudoTrace.psc` is staged into the game's `Source\User\` (which is already an import path) for compilation, then removed.
- Flags file: `%CK%\Data\Scripts\Source\Base\Institute_Papyrus_Flags.flg`
- Base game scripts (2403 files) extracted from CK `Base.zip` to game's `Data\Scripts\Source\` — required for compiler to resolve `Debug`, `Game`, `Actor`, etc.

## Architecture

### Triggers (no ESP needed)
- Hydra Script Function Runner calls global Papyrus functions on game events via `dist/Data/Hydra/ScriptFunctions/LudoTrace.json`
- Hydra:Events supports global FunctionRefs — event callbacks can be registered from global functions, no persistent script object needed
- **OnPostLoadGame** → `OnPostLoadGameEvent(Hydra:Events:PostLoadGameParams)` — registers all session event listeners, writes session-start state
- **OnPostSaveGame** → `OnPostSaveGameEvent(Hydra:Events:PostSaveGameParams)` — reads session-start state, reads events log, writes combined snapshot
- Script Function Runner requires the callback function to have the exact Params struct as its only parameter

### Session tracking model
```
On Load:
  → Register for all Hydra events (see OnPostLoadGameEvent)
  → Write line 1 of LudoTrace_Events.jsonl: session_start (clears file first)
    — includes level, SPECIAL, bobbleheads, ammo counts, aid counts

During session:
  → Each event appends one JSON line to LudoTrace_Events.jsonl
    {"type":"location","name":"Goodneighbor","time":"14:32"}
    {"type":"kill","target":"Raider","killer":"","time":"14:45"}

On Save:
  → Append final line: session_end (same schema as session_start)
  → Full session = first line (session_start) + events + last line (session_end)
  → Claude diffs session_start vs session_end for inventory/SPECIAL deltas
```

### Snapshot format (actual — JSONL)
See README.md "Snapshot format" section for sample rows of every event type.
Key event types: `session_start`, `session_end`, `location`, `near_collectible`,
`found`, `used`, `kill`, `stat`, `quest`, `quest_stage`, `av_change`, `combat`,
`limb`, `menu_mode`, `activate`, `container`, `destruction`, `objective`.

## Hydra API we use
- `Hydra:IO:File.WriteAllLines(path, string[])` — overwrite file
- `Hydra:IO:File.AppendLine(path, string)` — append one line (used for event stream)
- `Hydra:IO:File.ReadAllLines(path)` — read back a file
- `Hydra:IO:File.Exists(path)` — check before reading
- `Hydra:Time.GetGameYear/Month/Day/Hour/Minute()` — in-game calendar
- `Hydra:Events.RegisterFor*(FunctionRef)` — event listeners (31 event types active)
- `Hydra:FunctionRefs.CreateGlobalRef(scriptName, functionName)` — FunctionRef for a global function
- `Hydra:TempSet.Add(namespace, key)` / `ContainsKey(namespace, key)` — in-memory set, resets on load; used for location dedup (namespace "sc_locations")
- `Hydra:Forms:Cell.GetLocation(cell)` — resolves a cell to its named Location form
- `Hydra:Forms:Actor.GetActorBase(actor)` — get ActorBase from Actor
- `Hydra:Forms:ActorBase.GetPerks(actorBase)` — returns PerkRank[] (crashes at load time; safe via console trigger only)
- `Hydra:Strings.Contains(str, substr)` — substring check

## Known Hydra issues
- `Hydra:Forms:Form.GetName(actor)` crashes — use `actor.GetDisplayName()` for Actor/ObjectReference
- `Location` is not a Form subtype in Papyrus — `loc as Form` is unsafe; use `Hydra:Forms:Cell.GetLocation(cell)` then `loc.GetName()` instead
- `LocationEnterExit` fires for ALL actors (NPC home locations) — replaced by `CellEnterExit` filtered to `kSourceActor == Game.GetPlayer()`
- `Hydra:Forms:ActorBase.GetPerks()` crashes when called at load time (OnPostLoadGame context); safe when triggered from console via `cgf`

## Papyrus reserved name gotchas
- `state` is a reserved keyword (case-insensitive, same as `State`/`EndState`) — use `sState`
- `action` is a reserved base script type — use `sAction`
- `OnMenuOpenCloseEvent` conflicts with a vanilla ScriptObject event — our Hydra callback uses `OnMenuOpenCloseCB` instead
- Helper functions that return a value must declare return type: `string Function Foo() Global` not `Function Foo() Global`

## What's proven working
- Auto-trigger on load via Script Function Runner ✅
- File writing via `Hydra:IO:File.WriteAllLines` ✅
- File appending via `Hydra:IO:File.AppendLine` ✅
- `player.GetDisplayName()` for player name ✅
- `Hydra:Time` for in-game date/time ✅
- SPECIAL stats via `GetValue` ✅
- 31 event types streaming to `LudoTrace_Events.jsonl` via global `CreateGlobalRef` callbacks ✅
- `session_start` written on load (clears JSONL), `session_end` appended on save ✅
- `session_start`/`session_end` include: level, SPECIAL, bobbleheads, ammo counts, aid counts ✅
- `CellEnterExit` filtered to player via `kSourceActor == Game.GetPlayer()` for location tracking ✅
- `Hydra:Forms:Cell.GetLocation()` resolves interior cells to named Location ✅
- `Hydra:TempSet` for location dedup across a session ✅
- Bobblehead radar: `near_collectible` event + HUD notification when entering a bobblehead location ✅
- `OnItemAddRemoveEvent`: `found` event for bobblehead pickup, `used` event for aid items ✅
- `stat` events (`MiscStatChange`) capture Objects Built, Creatures Killed, Caps, etc. ✅
- Ammo + aid inventory snapshot via `Game.GetForm()` + `GetItemCount()` (same pattern as bobbleheads) ✅
- `av_change` events filtered to SPECIAL form IDs 706–712 ✅

## Event blacklist (too noisy, commented out)
- `perk_run` (`PerkEntryRun`) — passive perk effects every calculation, 68K events/session
- `trigger` (`TriggerEnterLeave`) — invisible volumes, pure noise
- `equip` (`ItemEquipUnequip`) — fires for NPCs too, unreliable for player gear

## ActorValueChange / SPECIAL tracking
We ARE registered for `ActorValueChange`, but filter to SPECIAL form IDs 706–712 only (Strength–Luck).
All other AV changes (health, AP, rad, etc.) are dropped in the callback before logging.
The `av_change` event fires on bobblehead pickup, capturing the before/after values.

## Layer roadmap
- **Layer 1** ✅ SPECIAL, level, player name, auto-trigger on load, repo scaffolded
- **Prove-out** ✅ Global Hydra event callbacks confirmed working
- **Layer 2** ✅ session_start/end model, JSONL event stream, 31 event types, bobblehead radar, ammo+aid inventory snapshot
- **Next**: Perks snapshot (DumpPerks works via console, needs safe call site), magazines, active quests
- **Later**: Session delta summary, holotape trigger, LudoTrace.esp

## Mod dependencies (must be installed by end user)
- F4SE (f4se.silverlock.org)
- Hydra (nexusmods.com/fallout4/mods/104159)
- Address Library for F4SE Plugins
- Visual C++ Redistributable 2022+
