Scriptname SessionCoach

; ---------------------------------------------------------------
; WriteSnapshot — builds and writes the snapshot file.
; Callable from console:  cgf "SessionCoach.WriteSnapshot"
; ---------------------------------------------------------------
Function WriteSnapshot() Global
    Actor player = Game.GetPlayer()
    int   lvl    = Game.GetPlayerLevel()

    int str  = player.GetValue(Game.GetStrengthAV())     as int
    int per  = player.GetValue(Game.GetPerceptionAV())   as int
    int endu = player.GetValue(Game.GetEnduranceAV())    as int
    int cha  = player.GetValue(Game.GetCharismaAV())     as int
    int inte = player.GetValue(Game.GetIntelligenceAV()) as int
    int agi  = player.GetValue(Game.GetAgilityAV())      as int
    int luc  = player.GetValue(Game.GetLuckAV())         as int

    int year  = Hydra:Time.GetGameYear()
    int month = Hydra:Time.GetGameMonth()
    int day   = Hydra:Time.GetGameDay()

    string playerName    = player.GetDisplayName()
    string locationName  = "(location not available)"

    string header1  = "=== FO4 SESSION COACH - SNAPSHOT ==="
    string header2  = "Generated: " + year + "-" + month + "-" + day
    string header3  = "Character: " + playerName + " | Level: " + lvl + " | Location: " + locationName
    string blank    = ""
    string special1 = "=== S.P.E.C.I.A.L. ==="
    string special2 = "S " + str + "  P " + per + "  E " + endu + "  C " + cha + "  I " + inte + "  A " + agi + "  L " + luc

    string[] lines = new string[6]
    lines[0] = header1
    lines[1] = header2
    lines[2] = header3
    lines[3] = blank
    lines[4] = special1
    lines[5] = special2

    Hydra:IO:File.WriteAllLines("SessionCoach_Snapshot.txt", lines)
    Debug.Notification("[Session Coach] Snapshot written!")
EndFunction

; ---------------------------------------------------------------
; OnPostLoadGameEvent — Hydra Script Function Runner entry point.
; Registers all session event listeners, then writes snapshot.
; ---------------------------------------------------------------
Function OnPostLoadGameEvent(Hydra:Events:PostLoadGameParams akParams) Global
    ; Register for location changes — proves global event callbacks work.
    ; abPersistent = false: re-registers on each load, safe to call repeatedly.
    Hydra:Events.RegisterForLocationEnterExit( \
        Hydra:FunctionRefs.CreateGlobalRef("SessionCoach", "OnLocationEnterExitEvent"))

    WriteSnapshot()
EndFunction

; ---------------------------------------------------------------
; OnLocationEnterExitEvent — fires when any actor crosses a location
; boundary. We filter to player entering only.
; ---------------------------------------------------------------
Function OnLocationEnterExitEvent(Hydra:Events:LocationEnterExitParams akParams) Global
    if akParams.kSourceActor != Game.GetPlayer()
        return
    endif
    if akParams.kNewLocation == None
        return
    endif

    ; Prove-out: write a line to the events log so we can confirm it fired.
    Hydra:IO:File.AppendLine("SessionCoach_Events.jsonl", \
        "{\"type\":\"location\",\"fired\":true}")
    Debug.Notification("[Session Coach] Location event fired!")
EndFunction
