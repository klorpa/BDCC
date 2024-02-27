extends SlaveActionBase

func _init():
	id = "RewardPraise"
	actionType = Reward
	#extraSlaves = {}
	#sceneID = ""

func getVisibleName():
	return "Praise"

func getVisibleDesc():
	return "Tell them they're doing good"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var character:DynamicCharacter = GlobalRegistry.getCharacter(_slaveID)
	var npcSlavery:NpcSlave = character.getNpcSlavery()
	
	npcSlavery.handleReward(1)
	return {
		text = "You praise "+character.getName()+" for doing well.",
	}