class_name Scenario extends Node

"""
Choices:
	{
	"answerChoice" : [
		{ msg : "Outcome msg", stats: {
			HEALTH = -5,
		} }
	]
	}
"""
#Main_Dialog_Piece : The piece that is displayed initially. #Choices : The choices the user can make. #Reveal: How long in seconds for the outcome to be shown.
func _init(main_dialog_piece: String = "????????", choices: Dictionary = {}, reveal: int = -1):
	self.main_dialog_piece = main_dialog_piece
	self.choices = choices
	self.reveal = reveal
	


func determineOutcome(key: String) -> String:
	var outcomes: Array = self.choices[key]
	var random_outcome: Dictionary = outcomes.pick_random()
	for stat in random_outcome.STATS.keys():
		GameManager[stat] += random_outcome.STATS.stat
	
	return random_outcome.MSG
	#DialogSys.display(random_outcome["msg"])
