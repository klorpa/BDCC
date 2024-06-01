extends SceneBase

var isNaked = false
var isCaged = false
var corruption = 0.0
var isSlut = false
var isVerySlut = false
var isLusty = false
var nakedAndShy = false

func _init():
	sceneID = "articaEventPortalPanties1Scene"

func _run():
	if(state == ""):
		addCharacter("artica")
		isNaked = getFlag("ArticaModule.NoClothes", false)
		isCaged = getCharacter("artica").isWearingChastityCage()
		corruption = getModule("ArticaModule").getCorruption()
		isSlut = getModule("ArticaModule").isSlut()
		isVerySlut = getModule("ArticaModule").isVerySlut()
		isLusty = getModule("ArticaModule").isLusty()
		nakedAndShy = (isNaked && !isSlut)
		playAnimation(StageScene.Solo, "walk", {pc="artica"})
		aimCameraAndSetLocName("hall_mainentrance")
		saynn("Artica heads towards the main elevator, seemingly just exploring the station.."+str(" She keeps covering her private bits though.. which doesn't help much because she has quite a lot that she needs to cover.." if nakedAndShy else "")+"")

		saynn("She walks past the checkpoint and steps inside the elevator. It's hard to see which button she presses from far away.. but you notice that she is pressing the lowest one, the one for the floor with all the mine shafts..")

		addButton("Follow", "See where she goes next", "in_workshop")
	if(state == "in_workshop"):
		addCharacter("alexrynard")
		aimCameraAndSetLocName("mining_nearentrance")
		playAnimation(StageScene.Duo, "stand", {pc="artica", npc="alexrynard", bodyState={hard=true}})
		saynn("You take the next elevator when it arrives and pick the same floor.")

		saynn("As you step out.. you find the fluff under all the catwalks, where the things like pickaxes are handed out to inmates..")

		if (isNaked):
			saynn("[say=alexrynard]Really? You're gonna work like that? I'm not blind, you know.[/say]")

		else:
			saynn("[say=alexrynard]Really? You're gonna work like that? I'm not blind, you know.[/say]")

		saynn("[say=artica].. ..[/say]")

		saynn("You don't hear Artica from your hidden position, she is talking way too quietly compared to anyone else..")

		saynn("[say=alexrynard]You're really asking that? Can't you see?[/say]")

		saynn("Artica looks at herself.. and shrugs.")

		saynn("[say=alexrynard]I'd rather you not hurt your cock with that pickaxe. Go away.[/say]")

		saynn("The fluff lowers her head and starts heading away. The engineer sees that and rolls his eyes.")

		saynn("[say=alexrynard]Wait. Come back, inmate.[/say]")

		saynn("[say=artica]..?[/say]")

		saynn("Artica obediently returns to the foxy.")

		saynn("[say=alexrynard]Why are you here?[/say]")

		saynn("[say=artica].. .. ..[/say]")

		saynn("Engineer scratches his chin, thinking..")

		saynn("[say=alexrynard]Wanna be a test subject?[/say]")

		saynn("Artica blinks a lot, her body fidgeting, tail curling around her waist, ears lowering..")

		saynn("[say=alexrynard]So?[/say]")

		saynn("Artica blinks even more. So much so that the engineer decides to throw some kind of small case at her. The girl barely catches it, her whole frame bending from the weight of whatever is inside.")

		saynn("[say=alexrynard]I guess that's a yes. Follow me.[/say]")

		saynn("The engineer starts climbing the catwalk.. while Artica is barely able to keep up, panting softly while carrying the heavy case.")

		saynn("Interesting..")

		addButton("Follow", "See what happens next", "in_workshop_actually")
	if(state == "in_workshop_actually"):
		playAnimation(StageScene.Duo, "sit", {pc="artica", npc="alexrynard", bodyState={hard=true}})
		aimCameraAndSetLocName("eng_workshop")
		saynn("They head towards the workshop area. The place with a bunch of work tables, arts and crafts kind of deal.. but without the arts.. and where crafts can only be done under strict supervision..")

		saynn("The engineer points at the table and Artica drops the case there, panting just as much.")

		saynn("[say=alexrynard]Now sit.[/say]")

		saynn("She nods and takes a seat while the engineer opens the case.. revealing.. something..")

		saynn("You're pretty sure it's electronics of some kind. You can see components.. and wires.. but it's clearly the case of functionality over.. anything else really.")

		saynn("[say=alexrynard]I'm gathering data for my project. The more people test it, the faster it will work for other people.[/say]")

		saynn("Artica tilts her head while watching the foxy quickly assemble something, using some kind safety goggles as a base and attaching things to them.")

		saynn("[say=alexrynard]Entropy is important when you're dealing with complicated blackboxes such as brains. Yeah, it's possible to make a digital model of one.. but you need at least a hundred other brains to understand the complexity.. how it works..[/say]")

		saynn("He looks at the girl.. while she just blushes.")

		saynn("[say=alexrynard]Understand what I mean? We can not possibly understand what every neuron of our brain does. But every neuron in our brain does something. And so just remembering that info for each neuron would require.. at least a bigger brain. Machines though.. they kinda can..[/say]")

		saynn("It feels like the engineer can just go on and on forever..")

		saynn("[say=alexrynard]I don't know what the future holds for us. It feels like machines will play a huge part in it.. no matter what some people think.[/say]")

		saynn("Artica bleps. While the engineer seems to be done with his prototype..")

		saynn("[say=alexrynard]I also don't know why I'm explaining all of that.. Just put it on already.[/say]")

		saynn("He presents Artica.. a fancy visor.. with wires sticking out everywhere..")

		saynn("[say=alexrynard]What? Changed your mind? I won't judge if you want to go hit rocks with a pick axe.[/say]")

		saynn("Artica shakes her head and grabs the prototype..")

		addButton("Continue", "See what happens next", "artica_with_visor_on")
	if(state == "artica_with_visor_on"):
		addCharacter("artica", ["hypno", "naked"])
		playAnimation(StageScene.Duo, "sit", {pc="artica", npc="alexrynard", bodyState={hard=true, naked=true}})
		saynn("She carefully secures it around her head with the engineer's help..")

		saynn("[say=alexrynard]It's designed to improve your mood, that's all you need to know. Ready?[/say]")

		saynn("Artica nods, her cyan naive eyes sparkling with blind trust.. The engineer touches some wires together.. and the visor lights up with an inviting yellow glow.")

		saynn("Soft lights begin to dance across Artica's vision, her body relaxing almost instantly under the device's influence.")

		saynn("The engineer quickly notices the change in Artica's expression.. And yeah, you see it too, even from far away.. Her breathing is slower and deeper, her gaze directed straight.. And most importantly, her eyes.. something is happening to her eyes..")

		saynn("[say=alexrynard]I've never seen that kind of reaction. Do you hear me?[/say]")

		saynn("She nods, seemingly in full control of her body..")

		saynn("[say=alexrynard]How do you feel?[/say]")

		saynn("What happens after that question is.. strange..")

		saynn("Artica's paws begin to trail over her fur"+str(", sliding under her shorts and shirt, slowly taking them off.." if !isNaked else ", not covering or hiding any of her private bits anymore..")+"")

		saynn("Foxy raises a brow while the fluff.. starts touching her breasts, caressing the soft mounds, playing with the perky"+str(" swollen" if getCharacter("artica").isLactating() else "")+" nips..")

		saynn("[say=alexrynard]Is that how you are feeling?[/say]")

		saynn("She nods. Well, she is feeling.. herself.. her paws exploring her fluffy belly, sliding down to her drippy pussy and "+str("hard trobbing cock" if !isCaged else "drippy locked cock")+"..")

		saynn("[say=alexrynard]Alright, something is wrong. Stop.[/say]")

		saynn("Artica obeys.. immediately.. no questions asked. She sits still, just like before.. but now she is aroused, panting softly with her tongue out, her nips are aroused, her canine member is leaking pre, her pussy leaving a wet spot on the seat..")

		saynn("The engineer sighs and grumbles to himself..")

		saynn("[say=alexrynard]..why does everything I create is either taken away, somehow used as a weapon.. or becomes a sextoy..[/say]")

		saynn("Somehow Artica hears him.. but only the last part..")

		addButton("Continue", "See what happens next", "artica_becomes_sextoy")
	if(state == "artica_becomes_sextoy"):
		playAnimation(StageScene.Zonked, "tease", {pc="artica", npc="alexrynard", bodyState={naked=true, hard=true}})
		saynn("Artica instantly slides off the chair, assuming a very lewd position on the floor, her legs raised high to her shoulders, her toes curling as her paws sneak under her balls, obediently spreading her pussy for the enginner, proudly showcasing the slick cyan love tunnel..")

		saynn("Foxy looks at that sight.. and sighs.")

		saynn("[say=alexrynard]Right.. I'm pretty sure there is a bias in your mind..[/say]")

		saynn("Artica tilts her head.")

		saynn("[say=alexrynard]If we stop here, you're gonna do more slutty stuff, aren't you? You want to get off?[/say]")

		saynn("Artica nods eagerly, her tongue out and drooling, her hypnotized eyes watching the fancy colors with great interest.. Other engineers begin to notice the girl on the floor, stuck in a very compromised position.")

		saynn("[say=alexrynard]Well.. go ahead then. Show me how you feel or whatever. Just avoid my work bench.[/say]")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "in_workshop"):
		processTime(3*60)

	if(_action == "in_workshop_actually"):
		processTime(3*60)

	if(_action == "artica_with_visor_on"):
		processTime(3*60)

	if(_action == "artica_becomes_sextoy"):
		processTime(5*60)

	setState(_action)

func saveData():
	var data = .saveData()

	data["isNaked"] = isNaked
	data["isCaged"] = isCaged
	data["corruption"] = corruption
	data["isSlut"] = isSlut
	data["isVerySlut"] = isVerySlut
	data["isLusty"] = isLusty
	data["nakedAndShy"] = nakedAndShy

	return data

func loadData(data):
	.loadData(data)

	isNaked = SAVE.loadVar(data, "isNaked", false)
	isCaged = SAVE.loadVar(data, "isCaged", false)
	corruption = SAVE.loadVar(data, "corruption", 0.0)
	isSlut = SAVE.loadVar(data, "isSlut", false)
	isVerySlut = SAVE.loadVar(data, "isVerySlut", false)
	isLusty = SAVE.loadVar(data, "isLusty", false)
	nakedAndShy = SAVE.loadVar(data, "nakedAndShy", false)
