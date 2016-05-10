ScriptName dubhGenericMonitorPerkEffectScript Extends ActiveMagicEffect

ObjectReference[] NearbyActors = None

Actor Property PlayerRef Auto

Int Property TimerSeconds Auto
Int Property TimerID Auto

Formlist Property ActorTypeKeywordsList Auto

Perk Property MonitorPerk Auto
Spell Property MonitorSpell Auto
Float Property MonitorRadius Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	StartTimer(TimerSeconds, TimerID)
EndEvent

Event OnTimer(Int aiTimerID)
	If PlayerRef.HasPerk(MonitorPerk)
		Int i = 0
		Bool bBreak = False

		While (i < ActorTypeKeywordsList.GetSize()) && !bBreak
			If !PlayerRef.HasPerk(MonitorPerk)
				bBreak = True
			EndIf

			If !bBreak
				NearbyActors = PlayerRef.FindAllReferencesWithKeyword(ActorTypeKeywordsList.GetAt(i), MonitorRadius)
				NearbyActors = FilterArray(NearbyActors)
				AddPerkToNearbyActors(NearbyActors)
			EndIf

			i += 1
		EndWhile
	EndIf
EndEvent

ObjectReference[] Function FilterArray(ObjectReference[] akArray)
	ObjectReference[] kResult = None

	If akArray
		Int i = 0
		Bool bBreak = False

		While (i < akArray.Length) && !bBreak
			If !PlayerRef.HasPerk(MonitorPerk)
				bBreak = True
			EndIf

			ObjectReference kItem = akArray[i] as ObjectReference

			If kItem.Is3DLoaded() && !kItem.IsDisabled() && !kItem.IsDeleted()
				Actor kActor = kItem as Actor

				If kActor && (kActor != PlayerRef)
					If !kActor.IsDead()
						kResult.Add(kItem, 1)
					EndIf
				EndIf
			EndIf

			i += 1
		EndWhile
	EndIf

	Return kResult
EndFunction

Bool Function AddSpellToNearbyActors(ObjectReference[] akArray)
	If akArray
		Int i = 0
		Bool bBreak = False

		While i < akArray.Length
			If !PlayerRef.HasPerk(MonitorPerk)
				bBreak = True
			EndIf

			Actor kActor = akArray[i] as Actor
			kActor.AddSpell(MonitorSpell, False)

			i += 1
		EndWhile
	EndIf
EndFunction







Event OnCripple(ActorValue akActorValue, bool abCrippled)
EndEvent