extends Species

func _init():
	id = Species.Feline
	
func getVisibleName():
	return "Feline"

func getDefaultLegs():
	return "felineleg"

func getDefaultBreasts():
	return "humanbreasts"

func getDefaultTail():
	return "felinetail"

func isPlayable():
	return true

func getVisibleDescription():
	return "Cute fluffballs"

func getDefaultHead():
	return "felinehead"

func getDefaultArms():
	return "felinearms"

func getDefaultEars():
	return "felineears"
