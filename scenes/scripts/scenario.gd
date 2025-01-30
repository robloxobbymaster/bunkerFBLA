class_name Scenario extends Node

"""
Choices:
	{
		"CHOICE_1" : [
			"outcome_1" : {
				#put the amt you want the stat to change by.
				'health': -5
			},
			
			"outcome_2" : {
				'health' 5
			}
		]
	}
"""
#Main_Dialog_Piece : The piece that is displayed initially. #Choices : The choices the user can make. #Reveal: How long in seconds for the outcome to be shown.
func _init(main_dialog_piece: String = "????????", choices: Dictionary = {}, reveal: int = -1):
	self.main_dialog_piece = main_dialog_piece
	self.choices = choices
	self.reveal = reveal
	
