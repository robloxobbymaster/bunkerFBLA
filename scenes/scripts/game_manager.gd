extends Node

@export var SCORE: int = 0
@export var DEGRATION: float = 1 #per second

@export var isInScenario: bool = false

@export var HEALTH: int = 100:
	set(value):
		HEALTH = value
		GUI.reapplyValues()
		
@export var HUNGER: int = 100:
	set(value):
		HUNGER = value
		GUI.reapplyValues()
		
@export var THIRST: int = 100:
	set(value):
		THIRST = value
		GUI.reapplyValues()

@onready var SCENARIOS: Array = load_json_file("res://scenarios.json")["SCENARIOS"]
#copied function from a video to load json into a dictionary
func load_json_file(filePath : String) -> Dictionary:
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading file")
	
	else:
		print("File doesn't exist!")
		
	return {}
	



func _on_degration_timer_timeout() -> void:
	HEALTH-=DEGRATION
	HUNGER-=DEGRATION
	THIRST-=DEGRATION
	$DegrationTimer.start()


func _on_scenario_timer_timeout() -> void:
	if not isInScenario:
		var scenario: Scenario = Scenario.from_json(SCENARIOS.pick_random())
		await DialogSystem.display_scenario(scenario)
		$ScenarioTimer.start()
