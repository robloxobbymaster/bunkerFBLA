class_name Scenario extends Node

"""
JSON FORMAT:

{
	"main_dialog_piece" : msg,
	"choices" : choices,
	"reveal" : reveal
}

"""



"""
Choices:
	{

	I want 8 cans from you or else I take 5 health
	"answerChoice" : {
		OUTCOMES: [
		{ MSG : "Outcome msg", STATS: {
			HEALTH = [-100,-5],
		}, TRIGGERS: ["eat"],

		
		
		},
		TRIGGERS: ["beep"],
	]
	}
"""

var main_dialog_piece: String
var choices : Dictionary
var reveal: int
var outcomeStats: Dictionary

#to initialize the class from JSON object
static func from_json(json: Dictionary) -> Scenario:
	return Scenario.new(json.get("main_dialog_piece","??????"), json.get("choices", {}), json.get("reveal",0))


#Main_Dialog_Piece : The piece that is displayed initially. #Choices : The choices the user can make. #Reveal: How long in seconds for the outcome to be shown.
func _init(main_dialog_piece: String = "????????", choices: Dictionary = {}, reveal: int = -1):
	self.main_dialog_piece = main_dialog_piece
	self.choices = choices
	self.reveal = reveal
	self.outcomeStats = {}
	
	


func determineOutcome(key: String) -> String:
	var outcomes: Array = self.choices.get(key)
	var random_outcome: Dictionary = outcomes.pick_random()
	
	var stringArr: Array[String] = []
	
	parseAudio(random_outcome.get("TRIGGERS",stringArr))
	
	for stat in random_outcome.STATS.keys():
		var range: Array = random_outcome.STATS.get(stat)
		var adderStat: int =  (randi() % (range[1]-range[0]+1) + range[0])
		
		self.outcomeStats[stat] = adderStat
		
		GameManager[stat] += adderStat
	
	for stat in self.outcomeStats:
		print(stat)
	
	return random_outcome.MSG
	#DialogSys.display(random_outcome["msg"])

func parseAudio(triggerArray: Array[String]) -> void:
	for trigger in triggerArray:
		AudioManager.play(AudioManager.SoundIds[trigger.to_upper()])
