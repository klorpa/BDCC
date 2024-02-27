extends Reference
class_name SlaveEventBase

var id = "error"
var eventWeight = 1.0
var sceneID = ""

func canHappen(_npcSlavery:NpcSlave):
	return false

func shouldHappenChance(_npcSlavery:NpcSlave):
	return 0.0

func shouldHappen(_npcSlavery:NpcSlave):
	return RNG.chance(shouldHappenChance(_npcSlavery))

func runEvent(_npcSlavery:NpcSlave):
	return {
		text = "AN EVENT HAPPENED!",
	}

func reactSceneEnd(_npcSlavery:NpcSlave, _sceneResult):
	return

func onEventSkipped(_npcSlavery:NpcSlave):
	return

func getEventWeight():
	return eventWeight