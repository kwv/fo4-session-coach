# FO4 Session Coach

A Fallout 4 mod that writes a character snapshot after each play session.
Paste the snapshot into Claude.ai for coaching feedback — no API key required.

## Requirements

- [F4SE](https://f4se.silverlock.org/)
- [Hydra](https://www.nexusmods.com/fallout4/mods/104159)
- Address Library for F4SE Plugins

## Install

Drop the contents of `dist/Data/` into your Fallout 4 `Data/` folder, or install
via Vortex / Mod Organizer 2.

## Usage

Load any save. The snapshot is written automatically to:

```
Fallout 4\SessionCoach_Snapshot.json
```

You can also trigger it manually from the in-game console:

```
cgf "SessionCoach.WriteSnapshot"
```

Then paste the snapshot into Claude.ai using the prompt in `docs/coaching_prompt.md`.

## Building from source

1. Copy `tools/paths.example.bat` to `tools/paths.local.bat`
2. Fill in your `GAME` and `CK` paths
3. From WSL: `make build` (or `make build run` to also launch the game)
   From Windows: double-click `tools/compile.bat`

## Snapshot format

The log is a JSONL file — one JSON object per line. Every session begins with a
`session_start` record, ends with a `session_end` record, and has event records
in between.

**session_start / session_end** — character state snapshot (identical schema):
```json
{"type":"session_start","date":"2288-02-27","time":"01:09","level":40,"name":"Rhea",
 "special":{"S":11,"P":7,"E":4,"C":7,"I":8,"A":6,"L":7},
 "bobbleheads":["Charisma","Intelligence"],
 "ammo":{".308 Round":1001,"Shotgun Shell":238,"Fusion Cell":74,"Mini Nuke":14},
 "aid":{"Stimpak":248,"RadAway":7,"Rad-X":7,"Jet":3,"Stealth Boy":2}}
```
Ammo and aid only list non-zero counts. Diffing start vs end gives session deltas.

**Events** — appended as they happen during the session:
```jsonl
{"type":"location","name":"The Slog","time":"01:12"}
{"type":"near_collectible","category":"bobblehead","name":"Strength","location":"Mass Fusion Building","time":"05:39"}
{"type":"kill","target":"Feral Ghoul Reaver","killer":"","time":"05:30"}
{"type":"stat","stat":"Creatures Killed","value":826,"time":"05:34"}
{"type":"quest_stage","quest":"The Road to Freedom","stage":20,"time":"03:14"}
{"type":"quest","name":"Reunions","state":"completed","time":"04:45"}
{"type":"menu_mode","menu":"PipboyMenu","state":"Entered","time":"01:16"}
{"type":"used","category":"healing","item":"Stimpak","time":"05:41"}
{"type":"used","category":"chem","item":"Jet","time":"05:52"}
{"type":"av_change","av":"Perception","from":7,"to":8,"time":"05:35"}
{"type":"combat","actor":"Raider","state":2,"time":"05:30"}
{"type":"limb","actor":"Brotherhood Knight","state":"Crippled","time":"05:30"}
```

`killer` is empty when the player lands the kill directly; a companion name
indicates companion-assisted kills. `av_change` fires only for SPECIAL stats
(e.g. bobblehead pickup). `combat.state` 1 = in combat, 2 = out of combat.

## Notes

- `stubs/Hydra/Events.psc` is a minimal compilation stub for `Hydra:Events`.
  Papyrus Compiler v2.8.0.4 does not support struct arrays; this stub strips
  the array fields from `*Args` structs so the file compiles cleanly.
  Hydra's real compiled `.pex` is used at runtime — the stub is compile-time only.
