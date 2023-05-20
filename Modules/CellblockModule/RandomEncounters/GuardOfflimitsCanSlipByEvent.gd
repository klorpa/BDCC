extends EventBase

func _init():
	id = "GuardOfflimitsCanSlipByEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.CaughtOffLimits)

func react(_triggerID, _args):
	var encounterLevel = RNG.randi_range(0, 5)
	if(_args.size() > 0):
		encounterLevel = _args[0]
	
	var idToUse = grabNpcIDFromPoolOrGenerate(CharacterPool.Guards, [], GuardGenerator.new(), {NpcGen.Level: encounterLevel})
	
	if(idToUse == null || idToUse == ""):
		return false
		
	runScene("GuardOfflimitsCanSlipByScene", [idToUse])

	return true

func getPriority():
	return 4