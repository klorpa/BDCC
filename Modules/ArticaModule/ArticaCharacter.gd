extends Character

func _init():
	id = "artica"
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="ArticSkin"
	pickedSkinRColor=Color("ffffffff")
	pickedSkinGColor=Color("ff15eff2")
	pickedSkinBColor=Color("ff009b93")
	npcSkinData={
	"hair": {"r": Color("ffffffff"),"g": Color("ff15eff2"),"b": Color("ff009b93"),},
	"ears": {"b": Color("ff646464"),},
	"penis": {"r": Color("fff6f6f6"),"g": Color("ff15eff2"),"b": Color("ff009b93"),},
	}
	
	npcHasMenstrualCycle = true
	
func _getName():
	if(GM.main != null && !GM.main.getFlag("ArticaModule.s4happened", false)):
		return "White fluff"
	return "Artica"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "Shy lilac that has a very bright white fur"

func getChatColor():
	return '#ff15eff2'

func getSpecies():
	return ["icejogauni"]

func getThickness() -> int:
	return 70

func getFemininity() -> int:
	return 100

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("caninehead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("messyhair2"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("canineears2tribal"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 3
	giveBodypartUnlessSame(breasts)
	var penis = GlobalRegistry.createBodypart("caninepenis")
	penis.lengthCM = 22
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	var tail = GlobalRegistry.createBodypart("caninetail")
	tail.tailScale = 1.2
	giveBodypartUnlessSame(tail)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))

func getDefaultEquipment():
	var result = ["inmatecollar", "inmateuniformSexDeviant"]
	if(GM.main != null && GM.main.getFlag("ArticaModule.NoClothes", false)):
		result = ["inmatecollar"]
	if(GM.main != null && GM.main.getFlag("ArticaModule.wearsPortalPanties", false)):
		result.append("PortalPantiesUnlocked")
	return result

func adjustArtworkVariant(_variant:Array):
	if(GM.main != null && GM.main.getFlag("ArticaModule.NoClothes", false)):
		if(!_variant.has("naked")):
			_variant.append("naked")

func canDoSelfCare():
	return false
