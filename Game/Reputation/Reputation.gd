extends ReputationPlaceholder
class_name Reputation

var charID:String = ""
var levels:Dictionary = {}
var scores:Dictionary = {}

func isPlaceholder() -> bool:
	return false

func getChar():
	return GlobalRegistry.getCharacter(charID)

func getCharacter():
	return GlobalRegistry.getCharacter(charID)

func setCharacter(theChar):
	charID = theChar.getID()

func isPlayer() -> bool:
	return charID == "pc"

func addMessage(theText:String):
	GM.main.addMessage(theText)

func getRepLevel(_stat:String) -> int:
	if(!levels.has(_stat)):
		return 0
	return levels[_stat]

func getRepScore(_stat:String) -> float:
	if(!scores.has(_stat)):
		return 0.0
	return scores[_stat]

func isEventRequired(_eventID:String) -> bool:
	for repID in GlobalRegistry.getRepStats():
		var repStat:RepStatBase = GlobalRegistry.getRepStat(repID)
		var curLevel:int = getRepLevel(repID)
		var curScore:float = getRepScore(repID)
		var nextLevel:int = curLevel + 1
		var neededScore:float = repStat.getNeededScoreForLevel(nextLevel)
		if(curScore >= neededScore):
			var specialReq = repStat.getSpecialRequirementToReachLevel(nextLevel, self)
			if(specialReq != null && specialReq[0] == _eventID):
				return true
	return false

func handleSpecialEvent(_eventID:String):
	for repID in GlobalRegistry.getRepStats():
		var repStat:RepStatBase = GlobalRegistry.getRepStat(repID)
		var curLevel:int = getRepLevel(repID)
		var curScore:float = getRepScore(repID)
		var nextLevel:int = curLevel + 1
		var maxLevel:int = repStat.getMaxLevel()
		if(curLevel >= maxLevel):
			continue
		
		var neededScore:float = repStat.getNeededScoreForLevel(nextLevel)
		var specialReq = repStat.getSpecialRequirementToReachLevel(nextLevel, self)
		
		if(curScore >= neededScore && specialReq != null):
			var requiredKey = specialReq[0]
			
			if(requiredKey == _eventID):
				if(!levels.has(repID)):
					levels[repID] = 0
				levels[repID] += 1
				scores[repID] = 0.0
				onRepLevelChanged(repID, levels[repID], true, true)
		

func addRep(_stat:String, _howMuch:float, _showMessage:bool = true):
	var repStat:RepStatBase = GlobalRegistry.getRepStat(_stat)
	if(repStat == null):
		return
	
	var curLevel:int = getRepLevel(_stat)
	var curScore:float = getRepScore(_stat)
	
	if(_howMuch > 0.0):
		var nextLevel:int = curLevel + 1
		var maxLevel:int = repStat.getMaxLevel()
		var neededScore:float = repStat.getNeededScoreForLevel(nextLevel)
		
		if(!scores.has(_stat)):
			scores[_stat] = 0.0
		scores[_stat] += _howMuch
		
		var wasAbove:bool = (curScore >= neededScore)
		
		if(scores[_stat] >= neededScore):
			if(curLevel < maxLevel):
				var specialReq = repStat.getSpecialRequirementToReachLevel(curLevel+1, self)
				if(specialReq != null && isPlayer()):
					if(isPlayer() && !wasAbove):
						addMessage("A special condition is required to reach the next level for '"+repStat.getVisibleName()+"'. Check the Reputation tab")
					scores[_stat] = neededScore
				else:
					if(!levels.has(_stat)):
						levels[_stat] = 0
					levels[_stat] += 1
					scores[_stat] = 0.0
					onRepLevelChanged(_stat, levels[_stat], true, _showMessage)
			else:
				scores[_stat] = neededScore
		else:
			onRepScoreChanged(_stat, scores[_stat], true, _showMessage)
			
	elif(_howMuch < 0.0):
		var nextLevel:int = curLevel - 1
		var minLevel:int = repStat.getMinLevel()
		var neededScore:float = -repStat.getNeededScoreForLevel(nextLevel)
		
		if(!scores.has(_stat)):
			scores[_stat] = 0.0
		scores[_stat] += _howMuch
		
		if(scores[_stat] <= neededScore):
			if(curLevel > minLevel):
				if(!levels.has(_stat)):
					levels[_stat] = 0
				levels[_stat] -= 1
				scores[_stat] = 0.0
				onRepLevelChanged(_stat, levels[_stat], false, _showMessage)
			else:
				scores[_stat] = neededScore
		else:
			onRepScoreChanged(_stat, scores[_stat], false, _showMessage)
			
func onRepLevelChanged(_stat:String, _newLevel:int, _wentUp:bool, _showMessage:bool=true):
	if(isPlayer()):
		var repStat:RepStatBase = GlobalRegistry.getRepStat(_stat)
		if(repStat == null):
			return
		if(_wentUp):
			addMessage("Your '"+str(repStat.getVisibleName())+"' went up a level. You are now known as '"+repStat.getTextForLevel(_newLevel, self)+"'!")
		else:
			addMessage("Your '"+str(repStat.getVisibleName())+"' went down a level. You are now known as '"+repStat.getTextForLevel(_newLevel, self)+"'!")

func onRepScoreChanged(_stat:String, _newScore:float, _wentUp:bool, _showMessage:bool=true):
	if(isPlayer()):
		var repStat:RepStatBase = GlobalRegistry.getRepStat(_stat)
		if(repStat == null):
			return
		if(_wentUp):
			addMessage("Your '"+str(repStat.getVisibleName())+"' got increased")
		else:
			addMessage("Your '"+str(repStat.getVisibleName())+"' got decreased")

func addRepBelowLevel(_stat:String, _howMuch:float, _level:int, _showMessage:bool = true):
	var curLevel:int = getRepLevel(_stat)
	if(curLevel < _level):
		addRep(_stat, _howMuch, _showMessage)

func getInfoLines() -> Array:
	var result:Array = []
	
	for repID in GlobalRegistry.getRepStats():
		var repStat:RepStatBase = GlobalRegistry.getRepStat(repID)
		var level:int = getRepLevel(repID)
		#var score:float = getRepScore(repID)
		
		var repName:String = repStat.getVisibleName()
		var repTitle:String = repStat.getTextForLevel(level, self)
		
		var extraText:String = ""
		if(level >= repStat.getMaxLevel()):
			extraText = " (Max level reached)"
		if(level <= repStat.getMinLevel()):
			extraText = " (Min level reached)"
		
		result.append(repName+": "+repTitle+extraText)
		
	return result

func saveData():
	return {
		"levels": levels,
		"scores": scores,
	}

func loadData(_data):
	levels = SAVE.loadVar(_data, "levels", {})
	scores = SAVE.loadVar(_data, "scores", {})
