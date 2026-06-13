Scriptname Hydra:Events Const Hidden Native

;/
	Minimal compilation stub for SessionCoach.
	All *Args structs that contain array fields are replaced with int iEmptyStruct
	so this file compiles cleanly with Papyrus Compiler v2.8.0.4 (no struct arrays).
	The Params structs are kept verbatim — they are the callback parameter types we need.
	At runtime, Hydra's real compiled Events.pex is used; this stub is compile-time only.
/;

Import Hydra:Colors
Import Hydra:FunctionRefs

bool Function IsPersistent(FunctionRef akFunctionRef) Global Native
bool Function IsRegisteredForAny(FunctionRef akFunctionRef) Global Native

bool Function UnregisterForAny(FunctionRef akFunctionRef) Global Native
bool Function UnregisterForAllLocal(ScriptObject akObject) Global Native
bool Function UnregisterForAllGlobal(string asScriptName) Global Native


Struct UserEventArgs
	int iEmptyStruct = 0
EndStruct

Struct UserEventParams
	string sEventName
	int iEmptyArgs = 0
EndStruct

bool Function IsRegisteredForUserEvent(FunctionRef akFunctionRef) Global Native
bool Function RegisterForUserEvent(FunctionRef akFunctionRef, UserEventArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForUserEvent(FunctionRef akFunctionRef) Global Native

bool Function SendUserEvent(string asEventName, Var[] akArgs = none) Global Native
bool Function SendAppliedUserEvent(string asEventName, Var[] akArgs = none) Global Native


Struct DeleteGameArgs
	int iEmptyStruct = 0
EndStruct

Struct DeleteGameParams
	string sSaveName
EndStruct

bool Function IsRegisteredForDeleteGame(FunctionRef akFunctionRef) Global Native
bool Function RegisterForDeleteGame(FunctionRef akFunctionRef, DeleteGameArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForDeleteGame(FunctionRef akFunctionRef) Global Native


Struct NewGameArgs
	int iEmptyStruct = 0
EndStruct

Struct NewGameParams
	Quest kCharGenQuest
EndStruct

bool Function IsRegisteredForNewGame(FunctionRef akFunctionRef) Global Native
bool Function RegisterForNewGame(FunctionRef akFunctionRef, NewGameArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForNewGame(FunctionRef akFunctionRef) Global Native


Struct PostLoadGameArgs
	int iEmptyStruct = 0
EndStruct

Struct PostLoadGameParams
	bool bSucceeded
EndStruct

bool Function IsRegisteredForPostLoadGame(FunctionRef akFunctionRef) Global Native
bool Function RegisterForPostLoadGame(FunctionRef akFunctionRef, PostLoadGameArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForPostLoadGame(FunctionRef akFunctionRef) Global Native


Struct PostSaveGameArgs
	int iEmptyStruct = 0
EndStruct

Struct PostSaveGameParams
	string sSaveName
EndStruct

bool Function IsRegisteredForPostSaveGame(FunctionRef akFunctionRef) Global Native
bool Function RegisterForPostSaveGame(FunctionRef akFunctionRef, PostSaveGameArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForPostSaveGame(FunctionRef akFunctionRef) Global Native


Struct StartGameArgs
	int iEmptyStruct = 0
EndStruct

Struct StartGameParams
	bool bSucceeded
EndStruct

bool Function IsRegisteredForStartGame(FunctionRef akFunctionRef) Global Native
bool Function RegisterForStartGame(FunctionRef akFunctionRef, StartGameArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForStartGame(FunctionRef akFunctionRef) Global Native


Struct ActiveEffectApplyRemoveArgs
	int iEmptyStruct = 0
EndStruct

Struct ActiveEffectApplyRemoveParams
	Actor kSourceActor
	Actor kTargetActor
	ActiveMagicEffect kActiveEffect
	MagicEffect kBaseEffect
	bool bApplied
EndStruct

bool Function IsRegisteredForActiveEffectApplyRemove(FunctionRef akFunctionRef) Global Native
bool Function RegisterForActiveEffectApplyRemove(FunctionRef akFunctionRef, ActiveEffectApplyRemoveArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForActiveEffectApplyRemove(FunctionRef akFunctionRef) Global Native


Struct ActorDeathArgs
	int iEmptyStruct = 0
EndStruct

Struct ActorDeathParams
	Actor kSourceActor
	Actor kTargetActor
	bool bDied
EndStruct

bool Function IsRegisteredForActorDeath(FunctionRef akFunctionRef) Global Native
bool Function RegisterForActorDeath(FunctionRef akFunctionRef, ActorDeathArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForActorDeath(FunctionRef akFunctionRef) Global Native


Struct AIPackageChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct AIPackageChangeParams
	Actor kSourceActor
	Package kNewAIPackage
	bool bStarted
	bool bChanged
EndStruct

bool Function IsRegisteredForAIPackageChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForAIPackageChange(FunctionRef akFunctionRef, AIPackageChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForAIPackageChange(FunctionRef akFunctionRef) Global Native


Struct CombatStateChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct CombatStateChangeParams
	Actor kSourceActor
	Actor kTargetActor
	int iNewState
EndStruct

bool Function IsRegisteredForCombatStateChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForCombatStateChange(FunctionRef akFunctionRef, CombatStateChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForCombatStateChange(FunctionRef akFunctionRef) Global Native


Struct FurnitureEnterExitArgs
	int iEmptyStruct = 0
EndStruct

Struct FurnitureEnterExitParams
	Actor kSourceActor
	ObjectReference kTargetRef
	bool bEntered
EndStruct

bool Function IsRegisteredForFurnitureEnterExit(FunctionRef akFunctionRef) Global Native
bool Function RegisterForFurnitureEnterExit(FunctionRef akFunctionRef, FurnitureEnterExitArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForFurnitureEnterExit(FunctionRef akFunctionRef) Global Native


Struct ItemEquipUnequipArgs
	int iEmptyStruct = 0
EndStruct

Struct ItemEquipUnequipParams
	Actor kTargetActor
	ObjectReference kItemRef
	Form kItem
	bool bEquipped
EndStruct

bool Function IsRegisteredForItemEquipUnequip(FunctionRef akFunctionRef) Global Native
bool Function RegisterForItemEquipUnequip(FunctionRef akFunctionRef, ItemEquipUnequipArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForItemEquipUnequip(FunctionRef akFunctionRef) Global Native


Struct LifeStateChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct LifeStateChangeParams
	Actor kSourceActor
	int iOldState
	int iNewState
EndStruct

bool Function IsRegisteredForLifeStateChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForLifeStateChange(FunctionRef akFunctionRef, LifeStateChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForLifeStateChange(FunctionRef akFunctionRef) Global Native


Struct LimbCrippleArgs
	int iEmptyStruct = 0
EndStruct

Struct LimbCrippleParams
	Actor kSourceActor
	ActorValue kSourceLimb
	bool bCrippled
	bool bPartialCrippled
EndStruct

bool Function IsRegisteredForLimbCripple(FunctionRef akFunctionRef) Global Native
bool Function RegisterForLimbCripple(FunctionRef akFunctionRef, LimbCrippleArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForLimbCripple(FunctionRef akFunctionRef) Global Native


Struct LocationEnterExitArgs
	int iEmptyStruct = 0
EndStruct

Struct LocationEnterExitParams
	Actor kSourceActor
	Location kOldLocation
	Location kNewLocation
EndStruct

bool Function IsRegisteredForLocationEnterExit(FunctionRef akFunctionRef) Global Native
bool Function RegisterForLocationEnterExit(FunctionRef akFunctionRef, LocationEnterExitArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForLocationEnterExit(FunctionRef akFunctionRef) Global Native


Struct ActorValueChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct ActorValueChangeParams
	ObjectReference kSourceRef
	ActorValue kSourceValue
	float fOldValue
	float fNewValue
EndStruct

bool Function IsRegisteredForActorValueChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForActorValueChange(FunctionRef akFunctionRef, ActorValueChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForActorValueChange(FunctionRef akFunctionRef) Global Native


Struct AnimationGraphEventArgs
	int iEmptyStruct = 0
EndStruct

Struct AnimationGraphEventParams
	ObjectReference kSourceRef
	string sEventName
	string sPayload
EndStruct

bool Function IsRegisteredForAnimationGraphEvent(FunctionRef akFunctionRef) Global Native
bool Function RegisterForAnimationGraphEvent(FunctionRef akFunctionRef, AnimationGraphEventArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForAnimationGraphEvent(FunctionRef akFunctionRef) Global Native


Struct DestructionStageChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct DestructionStageChangeParams
	ObjectReference kSourceRef
	int iOldStage
	int iNewStage
EndStruct

bool Function IsRegisteredForDestructionStageChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForDestructionStageChange(FunctionRef akFunctionRef, DestructionStageChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForDestructionStageChange(FunctionRef akFunctionRef) Global Native


Struct DialogueTopicChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct DialogueTopicChangeParams
	ObjectReference kSourceRef
	TopicInfo kDialogueTopic
	bool bStarted
EndStruct

bool Function IsRegisteredForDialogueTopicChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForDialogueTopicChange(FunctionRef akFunctionRef, DialogueTopicChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForDialogueTopicChange(FunctionRef akFunctionRef) Global Native


Struct FormDeleteArgs
	int iEmptyStruct = 0
EndStruct

Struct FormDeleteParams
	int iSourceFormId
EndStruct

bool Function IsRegisteredForFormDelete(FunctionRef akFunctionRef) Global Native
bool Function RegisterForFormDelete(FunctionRef akFunctionRef, FormDeleteArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForFormDelete(FunctionRef akFunctionRef) Global Native


Struct FormIdChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct FormIdChangeParams
	int iOldFormId
	int iNewFormId
EndStruct

bool Function IsRegisteredForFormIdChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForFormIdChange(FunctionRef akFunctionRef, FormIdChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForFormIdChange(FunctionRef akFunctionRef) Global Native


Struct ItemAddRemoveArgs
	int iEmptyStruct = 0
EndStruct

Struct ItemAddRemoveParams
	ObjectReference kSourceRef
	ObjectReference kTargetRef
	ObjectReference kItemRef
	Form kItem
	int iItemCount
EndStruct

bool Function IsRegisteredForItemAddRemove(FunctionRef akFunctionRef) Global Native
bool Function RegisterForItemAddRemove(FunctionRef akFunctionRef, ItemAddRemoveArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForItemAddRemove(FunctionRef akFunctionRef) Global Native


Struct ObjectActivateArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectActivateParams
	ObjectReference kSourceRef
	ObjectReference kTargetRef
EndStruct

bool Function IsRegisteredForObjectActivate(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectActivate(FunctionRef akFunctionRef, ObjectActivateArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectActivate(FunctionRef akFunctionRef) Global Native


Struct ObjectGrabReleaseArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectGrabReleaseParams
	ObjectReference kTargetRef
	bool bGrabbed
EndStruct

bool Function IsRegisteredForObjectGrabRelease(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectGrabRelease(FunctionRef akFunctionRef, ObjectGrabReleaseArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectGrabRelease(FunctionRef akFunctionRef) Global Native


Struct ObjectHarvestArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectHarvestParams
	Actor kSourceActor
	ObjectReference kTargetRef
	Form kItem
EndStruct

bool Function IsRegisteredForObjectHarvest(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectHarvest(FunctionRef akFunctionRef, ObjectHarvestArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectHarvest(FunctionRef akFunctionRef) Global Native


Struct ObjectHitArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectHitData
	int iFlags
	Spell kHitEffect
	Spell kCriticalEffect
	Ammo kAmmo
	MaterialType kMaterialType
	float fBaseDamage
	float fTotalDamage
	float fPhysicalDamage
	float fLimbDamage
	float fBlockedDamageMult
	float fResistedPhysicalDamage
	float fResistedTypedDamage
	float fReflectedDamage
	float fSneakAttackMult
	float fCriticalDamageMult
	float fBonusHealthDamageMult
	float fPushBackMult
	int iStaggerMagnitude
	int iLimbLocation
EndStruct

Struct ObjectHitParams
	ObjectReference kSourceRef
	ObjectReference kTargetRef
	Form kSourceObject
	ObjectReference kSourceProjectileRef
	Projectile kSourceProjectile
	string sMaterialName
	ObjectHitData kHitData
EndStruct

bool Function IsRegisteredForObjectHit(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectHit(FunctionRef akFunctionRef, ObjectHitArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectHit(FunctionRef akFunctionRef) Global Native


Struct ObjectLoadUnloadArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectLoadUnloadParams
	ObjectReference kSourceRef
	bool bLoaded
EndStruct

bool Function IsRegisteredForObjectLoadUnload(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectLoadUnload(FunctionRef akFunctionRef, ObjectLoadUnloadArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectLoadUnload(FunctionRef akFunctionRef) Global Native


Struct ObjectOpenCloseArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectOpenCloseParams
	ObjectReference kSourceRef
	ObjectReference kTargetRef
	bool bOpened
EndStruct

bool Function IsRegisteredForObjectOpenClose(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectOpenClose(FunctionRef akFunctionRef, ObjectOpenCloseArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectOpenClose(FunctionRef akFunctionRef) Global Native


Struct ObjectResetArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectResetParams
	ObjectReference kSourceRef
EndStruct

bool Function IsRegisteredForObjectReset(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectReset(FunctionRef akFunctionRef, ObjectResetArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectReset(FunctionRef akFunctionRef) Global Native


Struct ObjectSellArgs
	int iEmptyStruct = 0
EndStruct

Struct ObjectSellParams
	ObjectReference kSourceRef
	Actor kTargetActor
	ObjectReference kItemRef
EndStruct

bool Function IsRegisteredForObjectSell(FunctionRef akFunctionRef) Global Native
bool Function RegisterForObjectSell(FunctionRef akFunctionRef, ObjectSellArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForObjectSell(FunctionRef akFunctionRef) Global Native


Struct SpellCastArgs
	int iEmptyStruct = 0
EndStruct

Struct SpellCastParams
	ObjectReference kSourceRef
	Spell kSpell
EndStruct

bool Function IsRegisteredForSpellCast(FunctionRef akFunctionRef) Global Native
bool Function RegisterForSpellCast(FunctionRef akFunctionRef, SpellCastArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForSpellCast(FunctionRef akFunctionRef) Global Native


Struct TriggerEnterLeaveArgs
	int iEmptyStruct = 0
EndStruct

Struct TriggerEnterLeaveParams
	ObjectReference kSourceRef
	ObjectReference kTargetRef
	bool bEntered
EndStruct

bool Function IsRegisteredForTriggerEnterLeave(FunctionRef akFunctionRef) Global Native
bool Function RegisterForTriggerEnterLeave(FunctionRef akFunctionRef, TriggerEnterLeaveArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForTriggerEnterLeave(FunctionRef akFunctionRef) Global Native


Struct BookReadArgs
	int iEmptyStruct = 0
EndStruct

Struct BookReadParams
	ObjectReference kBookRef
	Book kBook
EndStruct

bool Function IsRegisteredForBookRead(FunctionRef akFunctionRef) Global Native
bool Function RegisterForBookRead(FunctionRef akFunctionRef, BookReadArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForBookRead(FunctionRef akFunctionRef) Global Native


Struct ButtonUpDownArgs
	int iEmptyStruct = 0
EndStruct

Struct ButtonUpDownParams
	int iDeviceType
	int iButtonCode
	string sControlName
	float fAnalogValue
	float fHeldSeconds
EndStruct

bool Function IsRegisteredForButtonUpDown(FunctionRef akFunctionRef) Global Native
bool Function RegisterForButtonUpDown(FunctionRef akFunctionRef, ButtonUpDownArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForButtonUpDown(FunctionRef akFunctionRef) Global Native


Struct CellAttachDetachArgs
	int iEmptyStruct = 0
EndStruct

Struct CellAttachDetachParams
	Cell kSourceCell
	bool bAttached
	bool bPreProcessed
EndStruct

bool Function IsRegisteredForCellAttachDetach(FunctionRef akFunctionRef) Global Native
bool Function RegisterForCellAttachDetach(FunctionRef akFunctionRef, CellAttachDetachArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForCellAttachDetach(FunctionRef akFunctionRef) Global Native


Struct CellEnterExitArgs
	int iEmptyStruct = 0
EndStruct

Struct CellEnterExitParams
	Actor kSourceActor
	Cell kTargetCell
	bool bEntered
EndStruct

bool Function IsRegisteredForCellEnterExit(FunctionRef akFunctionRef) Global Native
bool Function RegisterForCellEnterExit(FunctionRef akFunctionRef, CellEnterExitArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForCellEnterExit(FunctionRef akFunctionRef) Global Native


Struct CellLoadArgs
	int iEmptyStruct = 0
EndStruct

Struct CellLoadParams
	Cell kSourceCell
EndStruct

bool Function IsRegisteredForCellLoad(FunctionRef akFunctionRef) Global Native
bool Function RegisterForCellLoad(FunctionRef akFunctionRef, CellLoadArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForCellLoad(FunctionRef akFunctionRef) Global Native


Struct CrosshairRefChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct CrosshairRefChangeParams
	ObjectReference kTargetRef
	bool bTargeted
EndStruct

bool Function IsRegisteredForCrosshairRefChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForCrosshairRefChange(FunctionRef akFunctionRef, CrosshairRefChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForCrosshairRefChange(FunctionRef akFunctionRef) Global Native


Struct DialogueTargetChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct DialogueTargetChangeParams
	ObjectReference kTargetRef
EndStruct

bool Function IsRegisteredForDialogueTargetChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForDialogueTargetChange(FunctionRef akFunctionRef, DialogueTargetChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForDialogueTargetChange(FunctionRef akFunctionRef) Global Native


Struct DifficultyChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct DifficultyChangeParams
	int iOldDifficulty
	int iNewDifficulty
EndStruct

bool Function IsRegisteredForDifficultyChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForDifficultyChange(FunctionRef akFunctionRef, DifficultyChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForDifficultyChange(FunctionRef akFunctionRef) Global Native


Struct HudColorUpdateArgs
	int iEmptyStruct = 0
EndStruct

Struct HudColorUpdateParams
	Color kNewColor
EndStruct

bool Function IsRegisteredForHudColorUpdate(FunctionRef akFunctionRef) Global Native
bool Function RegisterForHudColorUpdate(FunctionRef akFunctionRef, HudColorUpdateArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForHudColorUpdate(FunctionRef akFunctionRef) Global Native


Struct LevelIncreaseArgs
	int iEmptyStruct = 0
EndStruct

Struct LevelIncreaseParams
	int iNewLevel
EndStruct

bool Function IsRegisteredForLevelIncrease(FunctionRef akFunctionRef) Global Native
bool Function RegisterForLevelIncrease(FunctionRef akFunctionRef, LevelIncreaseArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForLevelIncrease(FunctionRef akFunctionRef) Global Native


Struct LocationLoadArgs
	int iEmptyStruct = 0
EndStruct

Struct LocationLoadParams
	Location kSourceLocation
EndStruct

bool Function IsRegisteredForLocationLoad(FunctionRef akFunctionRef) Global Native
bool Function RegisterForLocationLoad(FunctionRef akFunctionRef, LocationLoadArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForLocationLoad(FunctionRef akFunctionRef) Global Native


Struct LockPickArgs
	int iEmptyStruct = 0
EndStruct

Struct LockPickParams
	ObjectReference kTargetRef
	int iLockLevel
EndStruct

bool Function IsRegisteredForLockPick(FunctionRef akFunctionRef) Global Native
bool Function RegisterForLockPick(FunctionRef akFunctionRef, LockPickArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForLockPick(FunctionRef akFunctionRef) Global Native


Struct MenuModeEnterExitArgs
	int iEmptyStruct = 0
EndStruct

Struct MenuModeEnterExitParams
	string sMenuName
	bool bEntered
EndStruct

bool Function IsRegisteredForMenuModeEnterExit(FunctionRef akFunctionRef) Global Native
bool Function RegisterForMenuModeEnterExit(FunctionRef akFunctionRef, MenuModeEnterExitArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForMenuModeEnterExit(FunctionRef akFunctionRef) Global Native


Struct MenuOpenCloseArgs
	int iEmptyStruct = 0
EndStruct

Struct MenuOpenCloseParams
	string sMenuName
	bool bOpened
EndStruct

bool Function IsRegisteredForMenuOpenClose(FunctionRef akFunctionRef) Global Native
bool Function RegisterForMenuOpenClose(FunctionRef akFunctionRef, MenuOpenCloseArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForMenuOpenClose(FunctionRef akFunctionRef) Global Native


Struct MiscStatChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct MiscStatChangeParams
	string sStatId
	int iNewValue
EndStruct

bool Function IsRegisteredForMiscStatChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForMiscStatChange(FunctionRef akFunctionRef, MiscStatChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForMiscStatChange(FunctionRef akFunctionRef) Global Native


Struct PerkEntryRunArgs
	int iEmptyStruct = 0
EndStruct

Struct PerkEntryRunParams
	Actor kSourceActor
	ObjectReference kTargetRef
	Perk kPerk
	int iEntryId
EndStruct

bool Function IsRegisteredForPerkEntryRun(FunctionRef akFunctionRef) Global Native
bool Function RegisterForPerkEntryRun(FunctionRef akFunctionRef, PerkEntryRunArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForPerkEntryRun(FunctionRef akFunctionRef) Global Native


Struct PerkPointIncreaseArgs
	int iEmptyStruct = 0
EndStruct

Struct PerkPointIncreaseParams
	int iNewCount
EndStruct

bool Function IsRegisteredForPerkPointIncrease(FunctionRef akFunctionRef) Global Native
bool Function RegisterForPerkPointIncrease(FunctionRef akFunctionRef, PerkPointIncreaseArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForPerkPointIncrease(FunctionRef akFunctionRef) Global Native


Struct PipBoyLightChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct PipBoyLightChangeParams
	bool bEnabled
EndStruct

bool Function IsRegisteredForPipBoyLightChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForPipBoyLightChange(FunctionRef akFunctionRef, PipBoyLightChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForPipBoyLightChange(FunctionRef akFunctionRef) Global Native


Struct PowerArmorLightChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct PowerArmorLightChangeParams
	bool bEnabled
EndStruct

bool Function IsRegisteredForPowerArmorLightChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForPowerArmorLightChange(FunctionRef akFunctionRef, PowerArmorLightChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForPowerArmorLightChange(FunctionRef akFunctionRef) Global Native


Struct QuestObjectiveChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct QuestObjectiveChangeParams
	Quest kSourceQuest
	int iNewObjectiveId
	int iOldObjectiveState
	int iNewObjectiveState
EndStruct

bool Function IsRegisteredForQuestObjectiveChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForQuestObjectiveChange(FunctionRef akFunctionRef, QuestObjectiveChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForQuestObjectiveChange(FunctionRef akFunctionRef) Global Native


Struct QuestStageChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct QuestStageChangeParams
	Quest kSourceQuest
	int iNewStageId
	int iNewItemId
	bool bCompleted
EndStruct

bool Function IsRegisteredForQuestStageChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForQuestStageChange(FunctionRef akFunctionRef, QuestStageChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForQuestStageChange(FunctionRef akFunctionRef) Global Native


Struct QuestStartStopArgs
	int iEmptyStruct = 0
EndStruct

Struct QuestStartStopParams
	Quest kSourceQuest
	bool bStarted
	bool bFailed
EndStruct

bool Function IsRegisteredForQuestStartStop(FunctionRef akFunctionRef) Global Native
bool Function RegisterForQuestStartStop(FunctionRef akFunctionRef, QuestStartStopArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForQuestStartStop(FunctionRef akFunctionRef) Global Native


Struct SceneActionChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct SceneActionChangeParams
	Scene kSourceScene
	int iNewActionId
	ReferenceAlias kRefAlias
EndStruct

bool Function IsRegisteredForSceneActionChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForSceneActionChange(FunctionRef akFunctionRef, SceneActionChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForSceneActionChange(FunctionRef akFunctionRef) Global Native


Struct ScenePhaseChangeArgs
	int iEmptyStruct = 0
EndStruct

Struct ScenePhaseChangeParams
	Scene kSourceScene
	int iNewPhaseIndex
	bool bStarted
EndStruct

bool Function IsRegisteredForScenePhaseChange(FunctionRef akFunctionRef) Global Native
bool Function RegisterForScenePhaseChange(FunctionRef akFunctionRef, ScenePhaseChangeArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForScenePhaseChange(FunctionRef akFunctionRef) Global Native


Struct SceneStartStopArgs
	int iEmptyStruct = 0
EndStruct

Struct SceneStartStopParams
	Scene kSourceScene
	bool bStarted
EndStruct

bool Function IsRegisteredForSceneStartStop(FunctionRef akFunctionRef) Global Native
bool Function RegisterForSceneStartStop(FunctionRef akFunctionRef, SceneStartStopArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForSceneStartStop(FunctionRef akFunctionRef) Global Native


Struct SleepStartStopArgs
	int iEmptyStruct = 0
EndStruct

Struct SleepStartStopParams
	ObjectReference kTargetRef
	float fStartTime
	float fDesiredEndTime
	bool bStarted
	bool bInterrupted
EndStruct

bool Function IsRegisteredForSleepStartStop(FunctionRef akFunctionRef) Global Native
bool Function RegisterForSleepStartStop(FunctionRef akFunctionRef, SleepStartStopArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForSleepStartStop(FunctionRef akFunctionRef) Global Native


Struct TerminalHackArgs
	int iEmptyStruct = 0
EndStruct

Struct TerminalHackParams
	ObjectReference kTargetRef
	int iLockLevel
EndStruct

bool Function IsRegisteredForTerminalHack(FunctionRef akFunctionRef) Global Native
bool Function RegisterForTerminalHack(FunctionRef akFunctionRef, TerminalHackArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForTerminalHack(FunctionRef akFunctionRef) Global Native


Struct TerminalMenuItemRunArgs
	int iEmptyStruct = 0
EndStruct

Struct TerminalMenuItemRunParams
	ObjectReference kTerminalRef
	Terminal kTerminal
	int iMenuItemId
EndStruct

bool Function IsRegisteredForTerminalMenuItemRun(FunctionRef akFunctionRef) Global Native
bool Function RegisterForTerminalMenuItemRun(FunctionRef akFunctionRef, TerminalMenuItemRunArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForTerminalMenuItemRun(FunctionRef akFunctionRef) Global Native


Struct TutorialTriggerArgs
	int iEmptyStruct = 0
EndStruct

Struct TutorialTriggerParams
	string sEventName
	Message kSentMessage
EndStruct

bool Function IsRegisteredForTutorialTrigger(FunctionRef akFunctionRef) Global Native
bool Function RegisterForTutorialTrigger(FunctionRef akFunctionRef, TutorialTriggerArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForTutorialTrigger(FunctionRef akFunctionRef) Global Native


Struct WaitStartStopArgs
	int iEmptyStruct = 0
EndStruct

Struct WaitStartStopParams
	float fStartTime
	float fDesiredEndTime
	bool bStarted
	bool bInterrupted
EndStruct

bool Function IsRegisteredForWaitStartStop(FunctionRef akFunctionRef) Global Native
bool Function RegisterForWaitStartStop(FunctionRef akFunctionRef, WaitStartStopArgs akArgs = none, bool abPersistent = false) Global Native
bool Function UnregisterForWaitStartStop(FunctionRef akFunctionRef) Global Native
