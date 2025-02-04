class_name Scenario extends Node

"""
JSON FORMAT:

{
	"main_dialog_piece" : msg,
	"choices" : choices,
	"reveal" : reveal

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
		CALLABLES

		
		
		},
		TRIGGERS: ["beep"],
		CALLABLES: ["kill"]
	]
	}
"""

var main_dialog_piece: String
var choices : Dictionary
var reveal: int
var outcomeStats: Dictionary

var imageAddress: String
var senderName: String

#to initialize the class from JSON object
static func from_json(json: Dictionary) -> Scenario:
	var default_values = Scenario.new()
	return Scenario.new(json.get("main_dialog_piece",default_values.main_dialog_piece), json.get("choices", default_values.choices), json.get("reveal",default_values.reveal), json.get("imageaddress", default_values.imageAddress), json.get("sendername", default_values.senderName))


#Main_Dialog_Piece : The piece that is displayed initially. #Choices : The choices the user can make. #Reveal: How long in seconds for the outcome to be shown.
func _init(main_dialog_piece: String = "????????", choices: Dictionary = {}, reveal: int = -1, imageAddress: String = "res://graphics/dialogSystem/mysteriousIcon.png", senderName: String = "??????"):
	self.main_dialog_piece = main_dialog_piece
	self.choices = choices
	self.reveal = reveal
	self.outcomeStats = {}
	self.imageAddress = imageAddress
	self.senderName = senderName
	


func determineOutcome(key: String) -> String:
	var outcomes: Array = self.choices.get(key)
	var random_outcome: Dictionary = outcomes.pick_random()
	
	var stringArr: Array[String] = []
	
	parseAudio(random_outcome.get("TRIGGERS",stringArr))
	random_outcome.STATS = random_outcome.get("STATS",{})
	for stat in random_outcome.STATS.keys():
		var range: Array = random_outcome.STATS.get(stat)
		var adderStat: int =  (randi() % (int(range[1])-int(range[0])+1) + int(range[0]))
		
		self.outcomeStats[stat] = adderStat
		
		GameManager[stat] += adderStat
	
	var GAINED: Array[String] = []
	var LOST: Array[String] = []

	for stat in self.outcomeStats:
		var value = self.outcomeStats[stat]
		if value > 0:
			GAINED.append("%d %s" % [value, stat.to_lower()])
		elif value < 0:
			LOST.append("%d %s" % [-1*value, stat.to_lower()])
			
	if GAINED.size() < 1: GAINED.append("nothing")
	if LOST.size() < 1: LOST.append("nothing")
		
			
			
	return random_outcome.MSG + ("\n\nGained %s." % ", ".join(GAINED)) + ("\nLost %s." % ", ".join(LOST))
	#DialogSys.display(random_outcome["msg"])

static func parseAudio(triggerArray: Array[String]) -> void:
	for trigger in triggerArray:
		AudioManager.play(AudioManager.SoundIds[trigger.to_upper()])

static func parseCallables(callableArray: Array[String]) -> void:
	for callable in callableArray:
		GameManager[callable].call()
