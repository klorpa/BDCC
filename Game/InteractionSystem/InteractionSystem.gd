extends Reference
class_name InteractionSystem

var pawns:Dictionary = {}
var pawnsByLoc:Dictionary = {}
var interactions:Array = []

func TEST_DELETE_ME():
	spawnPawn("pc")
	spawnPawn(RNG.pick(GM.main.dynamicCharacters))
	spawnPawn(RNG.pick(GM.main.dynamicCharacters))


func processTime(_howMuch:int):
#	var toUpdate:Array = getInteractionsThatNeedToProcessed()
#	while(toUpdate.size() > 0):
#		for interact in toUpdate:
#			pass
#
#		toUpdate = getInteractionsThatNeedToProcessed()
	#var currentTime:int = GM.main.getTime()

	#print(pawns)
	var maxProcesses:int = 50
	
	var interaction:PawnInteractionBase = getClosestInteraction()
	while(interaction != null && _howMuch > 0):
		var interactionBusySecs:int = interaction.busyActionSeconds
		if(_howMuch < interactionBusySecs):
			processBusyAllInteractions(_howMuch)
			break
		
		if(interactionBusySecs > 0):
			processBusyAllInteractions(interactionBusySecs)
			_howMuch -= interactionBusySecs
		interaction.doCurrentAction()
		
		if(!interaction.getCurrentPawn().isPlayer()):
			var actions = interaction.getActions()
			var selectedAction = actions[0]
			interaction.setPickedAction(selectedAction)
		
		maxProcesses -= 1
		if(maxProcesses <= 0):
			print("[Interaction System] HIT THE MAX PROCESS LIMIT")
			break
		interaction = getClosestInteraction()
		
		#pawn.processTime(_howMuch)
	print(pawnsByLoc)
	pass

func processBusyAllInteractions(howManySeconds:int):
	for pawnID in pawns:
		var pawn = pawns[pawnID]
		pawn.processTime(howManySeconds)
		var interaction = pawn.getInteraction()
		if(interaction == null || interactions.has(interaction)):
			continue
		interaction.busyActionSeconds -= howManySeconds
	for interaction in interactions:
		interaction.busyActionSeconds -= howManySeconds

func getClosestInteraction() -> PawnInteractionBase:
	var result = null
	for pawnID in pawns:
		var pawn = pawns[pawnID]
		var interaction = pawn.getInteraction()
		if(result == null || interaction.busyActionSeconds < result.busyActionSeconds):
			#if(!interaction.isPlayerInvolved()):
			result = interaction
	for interaction in interactions:
		if(result == null || interaction.busyActionSeconds < result.busyActionSeconds):
			#if(!interaction.isPlayerInvolved()):
			result = interaction
	return result

func spawnPawn(charID):
	if(charID == null):
		return
	var newPawn: CharacterPawn = CharacterPawn.new()
	newPawn.charID = charID
	
	if(pawns.has(charID)):
		deletePawn(charID)
	pawns[charID] = newPawn
	
	var loc = newPawn.getLocation()
	if(!pawnsByLoc.has(loc)):
		pawnsByLoc[loc] = {}
	pawnsByLoc[loc][charID] = true
	
	newPawn.onSpawn()

func deletePawn(charID):
	if(charID == null):
		return
	
	if(!pawns.has(charID)):
		return
	
	var pawn = pawns[charID]
	pawn.isDeleted = true
	var loc = pawn.getLocation()
	var _ok = pawns.erase(charID)
	if(pawnsByLoc.has(loc)):
		var _ok2 = pawnsByLoc[loc].erase(charID)

func onPawnMoved(charID, oldLoc:String, newLoc:String):
	if(charID == null):
		return
	if(oldLoc == newLoc):
		return
	if(pawnsByLoc.has(oldLoc)):
		var _ok2 = pawnsByLoc[oldLoc].erase(charID)
		if(pawnsByLoc[oldLoc].empty()):
			var _ok3 = pawnsByLoc.erase(oldLoc)
	if(!pawnsByLoc.has(newLoc)):
		pawnsByLoc[newLoc] = {}
	pawnsByLoc[newLoc][charID] = true

func getPawns() -> Dictionary:
	return pawns

func getPawn(charID:String) -> CharacterPawn:
	if(!pawns.has(charID)):
		return null
	return pawns[charID]

func getPawnsAt(loc:String) -> Array:
	if(!pawnsByLoc.has(loc)):
		return []
	var result := []
	
	for pawnID in pawnsByLoc[loc]:
		result.append(getPawn(pawnID))
#	for charID in pawns:
#		var pawn = pawns[charID]
#
#		if(pawn.getLocation() == loc):
#			result.append(pawn)
	
	return result

func getInteractionsAt(loc:String) -> Array:
	var result := []
	
	for interaction in interactions:
		if(interaction.getLocation() == loc):
			result.append(interaction)
	
	return result

func getInteractionsThatNeedToProcessed() -> Array:
	return []

# slow
func rebuildPawnsByLoc():
	pawnsByLoc.clear()
	
	for pawnID in pawns:
		var pawn = pawns[pawnID]
		var loc = pawn.getLocation()
		if(!pawnsByLoc.has(loc)):
			pawnsByLoc[loc] = {}
		pawnsByLoc[loc][pawnID] = true

func clearAll():
	for charID in pawns.keys():
		deletePawn(charID)
	pawns.clear()
	interactions.clear()

func startInteraction(interaction, involvedPawns:Dictionary):
	interactions.append(interaction)
	
	for pawnRole in involvedPawns:
		var pawn = getPawn(involvedPawns[pawnRole])
		stopInteractionsForPawnID(involvedPawns[pawnRole])
		pawn.setInteraction(interaction)
	
	interaction.start(involvedPawns)

func stopInteraction(interaction:PawnInteractionBase):
	interactions.erase(interaction)
	
	for pawnRole in interaction.involvedPawns:
		var pawn = getPawn(interaction.involvedPawns[pawnRole])
		if(pawn != null):
			pawn.setInteraction(null)

func stopInteractionsForPawnID(charID:String):
	for interaction in interactions.duplicate():
		for pawnRole in interaction.involvedPawns:
			if(interaction.involvedPawns[pawnRole] == charID):
				stopInteraction(interaction)
				break
