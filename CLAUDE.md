# FO4 Session Coach — Project Context

## What we're building
A Fallout 4 mod that writes a plain-text character snapshot after each play session.
The snapshot gets pasted into Claude.ai (no API key required) for coaching feedback.

The goal is a "coaching" feeling — not a tracker, not a cheat tool. 
A coaching layer that surfaces connections the game never makes for you:
- "You have a ghoul-slaying legendary but keep fighting ghouls with your pistol"
- "Your Sanctuary water farm is 3x more efficient than your Castle one"
- "You're level 38 with INT 7 and haven't taken Gun Nut past rank 1"

## Who it's for
- The player is on their first playthrough, playing sandbox style
- Not intentional about quest lines or faction alignment
- Doesn't want to be pushed toward an ending or forced into BoS/Institute choices
- Wants to enjoy the sandbox more deeply, not complete it faster

## Coaching philosophy
Surface missed opportunities based on what the player *already has*.
Focus on: build efficiency, nearby collectibles, settlement optimization, fun things nearby.

## Target audience (Nexus release)
This is intended as a community mod, not just a personal script.
Design decisions should consider:
- Works for any playstyle, not just this player's character
- No API key required — snapshot is pasted into Claude.ai manually
- Clean Nexus release with a recommended Claude prompt shipped alongside it

## Paths
- Game: `D:\SteamLibrary\steamapps\common\Fallout 4`
- Creation Kit + Papyrus Compiler: `D:\SteamLibrary\steamapps\common\Fallout 4 1946160`
- Compiler: `D:\SteamLibrary\steamapps\common\Fallout 4 1946160\Papyrus Compiler\PapyrusCompiler.exe`
- Our scripts go in: `D:\SteamLibrary\steamapps\common\Fallout 4\Data\Scripts\Source\User\`
- Snapshot output: `D:\SteamLibrary\steamapps\common\Fallout 4\SessionCoach_Snapshot.txt`
- Compile script: `D:\SteamLibrary\steamapps\common\Fallout 4\Data\Scripts\Source\User\compile_session_coach.bat`
- Hydra Script Function Runner config: `D:\SteamLibrary\steamapps\common\Fallout 4\Data\Hydra\ScriptFunctions\SessionCoach.json`

## Log paths
- F4SE + Hydra logs: `%MY_GAMES%\F4SE\`
  - `Hydra.log` — Script Function Runner errors, event registration failures
- Papyrus script logs (once enabled): `%MY_GAMES%\Logs\Script\`
- Fallout4Custom.ini: `%MY_GAMES%\Fallout4Custom.ini`

To enable Papyrus logging, add to `Fallout4Custom.ini`:
```ini
[Papyrus]
bEnableLogging=1
bEnableTrace=1
bLoadDebugInformation=1
```

## Mod structure (target)
```
Data\
  SessionCoach.esp           — plugin, contains holotape item
  Scripts\
    SessionCoach.pex         — compiled script
  Scripts\Source\User\
    SessionCoach.psc         — source script
  Sound\Voice\...            — holotape audio (later)
```

## Snapshot format (v1 target)
```
=== FO4 SESSION COACH — SNAPSHOT ===
Generated: <date> | Save #<n>
Character: <name> | Level: <n> | Location: <location>

=== S.P.E.C.I.A.L. ===
S <n>  P <n>  E <n>  C <n>  I <n>  A <n>  L <n>

=== PERKS ===
<perk name> <rank> | ...

=== BOBBLEHEADS ===
Collected (<n>/20): <list>
Missing: <list>

=== MAGAZINES ===
<series>: <n>/<total> collected
...

=== LEGENDARY ITEMS ===
<slot>: <item name> — <legendary effect>

=== AMMO ===
<type>: <count> | ...

=== SETTLEMENTS ===
<name>: Food <n> | Water <n> | Settlers <n> | Defense <n>
...

=== ACTIVE QUESTS ===
<quest name> — <current stage>
...
```

## Build order
1. **Layer 1 — Static snapshot**: SPECIAL, perks, bobbleheads, magazines → proves pipeline works
2. **Layer 2 — Session delta**: what changed since last snapshot (new perks, new collectibles)
3. **Layer 3 — Session events**: enemies killed by type, weapons used, ammo spent, locations visited

## Papyrus notes
- Triggered via holotape item (Aid section of inventory)
- File writing requires F4SE — player has F4SE installed
- Scripts live in `Source\User\`, compiled to `Scripts\`
- Base game source scripts (2403 files) extracted from CK `Base.zip` to `Data\Scripts\Source\` — required for compiler to find `Debug`, `Game`, `Actor`, etc.
- Test by triggering from console before packaging as holotape
- Console test command: `cgf "SessionCoach.WriteSnapshot"` — must close console first to see HUD notification
- Quick quit to desktop from console: `qqq`

## Compiler notes
- Papyrus Compiler v2.8.0.4 — does NOT support struct arrays (`string[]`, `Var[]`, `int[]` as struct fields)
- `Hydra:Events.psc` was replaced with a minimal compilation stub — all `*Args` structs that contained array fields are replaced with `int iEmptyStruct = 0`. The real Hydra `.pex` is used at runtime; the stub is compile-time only.
- Import path order in compile script: `Source\User` first (our scripts + Hydra sources), then `Source` (base game scripts)
- Flags file required: `D:\SteamLibrary\steamapps\common\Fallout 4 1946160\Data\Scripts\Source\Base\Institute_Papyrus_Flags.flg`

## Hydra Script Function Runner
- Config file: `Data\Hydra\ScriptFunctions\SessionCoach.json`
- For `OnPostLoadGame`, the callback function MUST have `Hydra:Events#PostLoadGameParams` as its only parameter — no other signature is accepted
- Our trigger wrapper: `Function OnPostLoadGameEvent(Hydra:Events:PostLoadGameParams akParams) Global`
- `WriteSnapshot()` stays zero-argument so it can still be called via `cgf`

## Known Hydra issues
- `Hydra:Forms:Form.GetName(actor)` crashes the game — use vanilla `actor.GetDisplayName()` instead for Actor/ObjectReference types
- `Location` is not a subtype of `Form` in Papyrus's type system — passing `loc as Form` to GetName is unsafe; location name is currently skipped (returns "(location not available)")

## Claude coaching prompt (ships with mod on Nexus)
This prompt goes in a README alongside the mod:

```
You are a Fallout 4 playthrough coach. I'm going to paste a character snapshot
generated by the Session Coach mod.

My playstyle: sandbox, first playthrough, not rushing the main quest, no strong
faction preference yet. I want to enjoy the world more deeply, not complete it faster.

Based on the snapshot, give me:
1. The 3 most impactful things I could do next session
2. Any "you have X but aren't using it" missed connections
3. One settlement tip if relevant
4. One collectible worth grabbing that's near my current location or active quests

Be specific — reference actual item names, perk names, and locations from the snapshot.
Don't suggest main quest progression or push faction choices.
```

## Reference mods (do not depend on, use as pattern reference only)
- **Collectibles Helper** (Jonx0r) — tracks bobbleheads/magazines via quest markers
- **FallComplete** — dynamically queries missing collectibles, quests, locations

## Current status
- Creation Kit installed, F4SE installed, Vortex installed
- Layer 1 in progress: SPECIAL + level + player name compiles and writes snapshot
- `cgf "SessionCoach.WriteSnapshot"` confirmed working (Step 2 = SPECIAL stats, Step 3 = Hydra:Time)
- Hydra:Events stub written; Script Function Runner trigger (`OnPostLoadGameEvent`) compiled — untested in-game
- Location name pending — safe method not yet found
- Next: confirm snapshot file writes correctly end-to-end, then Layer 2 (perks, bobbleheads, magazines)