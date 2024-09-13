extends Node
class_name ChildSystem

var children: Array = []
var archive: Dictionary = {}

func _ready():
	GM.CS = self
	name = "ChildSystem"

func addChild(child):
	children.append(child)
	
func getChildren():
	return children

func getChildrenOf(charID):
	var result = []
	for child in children:
		if((child.getMotherID() == charID) || (child.getFatherID() == charID)):
			result.append(child)
	return result

func getChildrenAmountOf(charID):
	var result = 0
	for child in children:
		if((child.getMotherID() == charID) || (child.getFatherID() == charID)):
			result += 1
	
	result += getArchiveChildCountMotherOrFather(charID)
	return result

func getChildrenAmountOfOnlyMother(charID):
	var result = 0
	for child in children:
		if(child.getMotherID() == charID):
			result += 1
	
	result += getArchiveChildCountMotherID(charID)
	return result

func getChildrenAmountOfOnlyFather(charID):
	var result = 0
	for child in children:
		if(child.getFatherID() == charID):
			result += 1
	
	result += getArchiveChildCountFatherID(charID)
	return result

func getSharedChildren(firstCharID, secondCharID):
	var result = []
	for child in children:
		if(((child.getMotherID() == firstCharID) && (child.getFatherID() == secondCharID)) || ((child.getFatherID() == firstCharID) && (child.getMotherID() == secondCharID))):
			result.append(child)
	return result

func getSharedChildrenAmount(firstCharID, secondCharID):
	var result = 0
	for child in children:
		if(((child.getMotherID() == firstCharID) && (child.getFatherID() == secondCharID)) || ((child.getFatherID() == firstCharID) && (child.getMotherID() == secondCharID))):
			result += 1
	
	result += getArchiveChildCountAny(firstCharID, secondCharID)
	return result

func getSharedChildrenAmountFatherMother(firstCharID, secondCharID):
	var result = 0
	for child in children:
		if((child.getFatherID() == firstCharID) || (child.getMotherID() == secondCharID)):
			result += 1
	result += getArchiveChildCount(firstCharID, secondCharID)
	return result

func getChildBirthInfoString(childs):
	var bornChildString = ""
	
	for child in childs:
		var fatherObject = GlobalRegistry.getCharacter(child.fatherID)
		var fatherName = "unknown"
		if(fatherObject != null):
			fatherName = fatherObject.getName()
		
		var motherObject = GlobalRegistry.getCharacter(child.motherID)
		var motherName = "unknown"
		if(motherObject != null):
			motherName = motherObject.getName()
		
		bornChildString += "[color="+NpcGender.getColorString(child.gender)+"]"+ NpcGender.getVisibleName(child.gender)+"[/color]"+" - "+Util.getSpeciesName(child.species)+" - "+"Mother: "+motherName+" - "+"Father: "+fatherName+"\n"
	return bornChildString

func shouldOptimize() -> bool:
	return false

func getMaxStoredRecordsForPC() -> int:
	return 50

func getMaxStoredRecordsForNPC() -> int:
	return 50

func optimize():
	if(!shouldOptimize()):
		return
	
	var kidAmountNPC:int = 0
	var kidAmountPC:int = 0
	for child in children:
		var motherID:String = child.getMotherID()
		var fatherID:String = child.getFatherID()
		if(motherID == "pc" || fatherID == "pc"):
			kidAmountPC += 1
		else:
			kidAmountNPC += 1
	
	var pcAmountKeep:int = getMaxStoredRecordsForPC()
	var npcAmountKeep:int = getMaxStoredRecordsForNPC()
	
	var _i:int = 0
	while(_i < children.size() && (kidAmountPC > pcAmountKeep || kidAmountNPC > npcAmountKeep)):
		var child:Child = children[_i]
		var motherID:String = child.getMotherID()
		var fatherID:String = child.getFatherID()
		
		var shouldRemove:bool = false
		
		if(motherID == "pc" || fatherID == "pc"):
			if(kidAmountPC > pcAmountKeep):
				kidAmountPC -= 1
				shouldRemove = true
		else:
			if(kidAmountNPC > npcAmountKeep):
				kidAmountNPC -= 1
				shouldRemove = true
		
		if(shouldRemove):
			addArchiveChild(motherID, fatherID)
			children.remove(_i)
		else:
			_i += 1
		

func getArchiveID(motherID:String, fatherID:String) -> String:
	return motherID+";"+fatherID

func addArchiveChild(motherID:String, fatherID:String):
	var theID:String = getArchiveID(motherID, fatherID)
	if(!archive.has(theID)):
		archive[theID] = 1
	else:
		archive[theID] = 0

func getArchiveChildCount(motherID:String, fatherID:String) -> int:
	var theID:String = getArchiveID(motherID, fatherID)
	if(!archive.has(theID)):
		return 0
	else:
		return archive[theID]

func getArchiveChildCountAny(charID1:String, charID2:String) -> int:
	var theID1:String = getArchiveID(charID1, charID2)
	var theID2:String = getArchiveID(charID2, charID1)
	
	if(theID1 == theID2):
		return (archive[theID1] if archive.has(theID1) else 0)
	else:
		return (archive[theID1] if archive.has(theID1) else 0) + (archive[theID2] if archive.has(theID2) else 0)

func getArchiveChildCountMotherID(motherID:String) -> int:
	var result:int = 0
	for theID in archive:
		var splitData:Array = theID.split(";")
		if(splitData[0] == motherID):
			result += 1
	return result

func getArchiveChildCountFatherID(fatherID:String) -> int:
	var result:int = 0
	for theID in archive:
		var splitData:Array = theID.split(";")
		if(splitData.size() > 1 && splitData[1] == fatherID):
			result += 1
	return result

func getArchiveChildCountMotherOrFather(charID:String) -> int:
	var result:int = 0
	for theID in archive:
		var splitData:Array = theID.split(";")
		if(splitData[0] == charID || (splitData.size() > 1 && splitData[1] == charID)):
			result += 1
	return result

func saveData():
	var data = {}

	var childData = []
	for child in children:
		childData.append(child.saveData())

	data["children"] = childData
	data["archive"] = archive

	return data

func loadData(data):
	children.clear()
	var childData = SAVE.loadVar(data, "children", [])
	archive = SAVE.loadVar(data, "archive", {})
	
	for child in childData:
		var childObject = Child.new()
		childObject.loadData(child)
		children.append(childObject)
