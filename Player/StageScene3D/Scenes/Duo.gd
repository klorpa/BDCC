extends BaseStageScene3D

onready var animationTree = $AnimationTree
onready var animationTree2 = $AnimationTree2
onready var doll = $Doll3D
onready var doll2 = $Doll3D2

func _init():
	id = StageScene.Duo

func _ready():
	animationTree.anim_player = animationTree.get_path_to(doll.getAnimPlayer())
	animationTree.active = true
	animationTree2.anim_player = animationTree2.get_path_to(doll2.getAnimPlayer())
	animationTree2.active = true

func updateSubAnims():
	if(doll.getArmsCuffed()):
		animationTree["parameters/CuffsBlend/blend_amount"] = 1.0
	else:
		animationTree["parameters/CuffsBlend/blend_amount"] = 0.0
	
	if(doll2.getArmsCuffed()):
		animationTree2["parameters/CuffsBlend/blend_amount"] = 1.0
	else:
		animationTree2["parameters/CuffsBlend/blend_amount"] = 0.0

# StageScene.Duo, "kneel", {npc="nova", pc="pc"}
func playAnimation(animID, _args = {}):
	print("Playing duo: "+str(animID))
	var firstDoll = "pc"
	if(_args.has("pc")):
		firstDoll = _args["pc"]
	doll.prepareCharacter(firstDoll)
	var secondDoll = "pc"
	if(_args.has("npc")):
		secondDoll = _args["npc"]
	doll2.prepareCharacter(secondDoll)
	
	#doll.forceSlotToBeVisible(BodypartSlot.Penis)
	
	if(_args.has("exposedBodyparts")):
		doll.setExposedBodyparts(_args["exposedBodyparts"])
	else:
		doll.setExposedBodyparts([])
	
	if(_args.has("npcExposedBodyparts")):
		doll2.setExposedBodyparts(_args["npcExposedBodyparts"])
	else:
		doll2.setExposedBodyparts([])
	
	if(animID == "sit"):
		$Chair.visible = true
	else:
		$Chair.visible = false
	
	updateSubAnims()
	
	var state_machine = animationTree["parameters/AnimationNodeStateMachine/playback"]
	if(!stateMachineTravel(doll, state_machine, animID)):
		Log.printerr("Action "+str(animID)+" is not found for stage "+str(id))
	
	$Chair2.visible = false
	if(_args.has("npcAction")):
		var npcAnimID = _args["npcAction"]
		if(npcAnimID == "sit"):
			$Chair2.visible = true
		
		var state_machine2 = animationTree2["parameters/AnimationNodeStateMachine/playback"]
		if(!stateMachineTravel(doll2, state_machine2, npcAnimID)):
			Log.printerr("Action "+str(animID)+" is not found for stage "+str(id))
	else:
		var state_machine2 = animationTree2["parameters/AnimationNodeStateMachine/playback"]
		stateMachineTravel(doll2, state_machine2, "stand")

func canTransitionTo(_actionID, _args = []):
	var firstDoll = "pc"
	if(_args.has("pc")):
		firstDoll = _args["pc"]
	var secondDoll = "pc"
	if(_args.has("npc")):
		secondDoll = _args["npc"]
		
	if(doll.getCharacterID() != firstDoll || doll2.getCharacterID() != secondDoll):
		return false
	return true
