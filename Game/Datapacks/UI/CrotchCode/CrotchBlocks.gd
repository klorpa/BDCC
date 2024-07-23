extends Object
class_name CrotchBlocks

const CALL = 0
const VALUE = 1
const LOGIC = 2
const RETURNCALL = 3

static func getLeftBracket(theType):
	if(theType == CALL):
		return "v"
	if(theType == VALUE):
		return "("
	if(theType == LOGIC):
		return "<"
	if(theType == RETURNCALL):
		return "x"
	return ""
	
static func getRightBracket(theType):
	if(theType == CALL):
		return ""
	if(theType == VALUE):
		return ")"
	if(theType == LOGIC):
		return ">"
	if(theType == RETURNCALL):
		return ""
	return ""

static func getAll():
	return [
		"AlwaysTrue",
		"AlwaysFalse",
		"AlwaysNull",
		"FlowIf",
		"FlowIfElse",
		"FlowWhile",
		
		"MathPlus",
		"MathMinus",
		"MathMult",
		"MathDivide",
		"MathFMod",
		"MathMod",
		"MathPow",
		"MathOp",
		
		"LogicAnd",
		"LogicOr",
		"LogicNot",
		
		"MathLogicEquals",
		"MathLogicNotEquals",
		"MathLogicBiggerThan",
		"MathLogicLessThan",
		"MathLogicBiggerThanOrEq",
		"MathLogicLessThanOrEq",
		
		"SceneOutput",
		"SceneSay",
		"SceneButton",
		"SceneButtonDisabled",
		"SceneAimCamera",
		"ScenePlayAnim",
		"SceneCharAdd",
		"SceneCharRem",
		"SceneSetState",
		"SceneGetState",
		"SceneEndScene",
		"SceneRunScene",
		"SceneStartFight",
		"SceneStartSex",
		"SceneStartLeashParade",
		"SceneAddMessage",
		"SceneSetLocName",
		
		"EventRun",
		"EventButton",
		"EventButtonDisabled",
		"EventOutput",
		"EventEndScene",
		"EventRunScene",
		"EventAddMessage",
		
		
		"QuestStage",
		"QuestMarkAsVisible",
		"QuestMarkAsCompleted",
		
		"LewdFuck",
		"LewdOrgasmFrom",
		"LewdCummedOnBy",
		"LewdCumInside",
		"LewdRubVaginas",
		"LewdHasX",
		"LewdGetX",
		"LewdIsLactating",
		"LewdIsPregnant",
		"LewdIsWearing",
		"LewdForceHeat",
		"LewdMilk",
		"LewdWriting",
		"LewdIsCoveredIn",
		"LewdHasBodypart",
		"LewdBodypartHasTrait",
		"LewdIsBodypartCovered",
		"LewdClearFluids",
		"LewdDamageClothes",
		"LewdDoStretchHole",
		"LewdDoStretchPain",
		"LewdStraponButtons",
		"LewdReturnStrapon",
		"LewdAddFilledCondom",
		"LewdGiveBirth",
		"LewdGetChildAmount",
		"LewdGetSharedChildAmount",
		"LewdBreastFeed",
		"LewdForceImpregnate",
		"LewdShouldCondomBreak",
		"LewdUseCondom",
		
		"GameProcessTime",
		"GameAddAtr",
		"GameGetAtr",
		"GameGetStat",
		"GameHasPerk",
		"GameHasEffect",
		"GameAddEffect",
		"GameRemoveEffect",
		"GameHasBuff",
		"GameGetSkillLevel",
		"GameAddSkillExp",
		"GameAddPCAtr",
		"GameGetPCAtr",
		"GameSetPCLocation",
		"GameIsPCInLocation",
		"GameDoWound",
		"GameCharExists",
		"GameGetDays",
		"GameGetTime",
		"GameStartNextDay",
		"GameAddLog",
		"GameShowLog",
		
		"InvAddItemID",
		"InvAddXOfItemID",
		"InvClearSlot",
		"InvForceEquipItemID",
		"InvGetItemIDCount",
		"InvGetItemsWithTagCount",
		"InvHasItemID",
		"InvHasItemIDEquipped",
		"InvHasItemsWithTag",
		"InvHasSlotEquipped",
		"InvHasXOfItemID",
		"InvRemoveItemID",
		"InvRemoveItemsWithTag",
		"InvRemoveXOfItemID",
		"InvResetInventory",
		
		"NpcGetPersStat",
		"NpcSetPersStat",
		"NpcAddPersStat",
		"NpcGetFetish",
		"NpcSetFetish",
		
		
		"Print",
		#"TestList",
		"VarGet",
		"VarSet",
		"VarSetStr",
		"VarSetBool",
		"VarInc",
		"VarIsNull",
		"VarIsBool",
		"VarIsNumber",
		"VarIsString",
		
		"RawString",
		"RawInt",
		"VarLocationName",
		
		"FlagGet",
		"FlagSet",
		"FlagSetStr",
		"FlagSetBool",
		"FlagInc",
		
		"ToString",
		"ToInt",
		"ToFloat",
		
		"RNGChance",
		"RNGFloat",
		"RNGInt",
		]

static func createBlock(theID):
	var resourcePath = "res://Game/Datapacks/UI/CrotchCode/CodeBlocks/"+theID+".gd"
	var newBlockScene = load(resourcePath)
	if(newBlockScene == null):
		return null
	var newBlock = newBlockScene.new()
		
	if(newBlock != null):
		newBlock.id = theID
	#	newBlock.initWithDefaultData()
	return newBlock
