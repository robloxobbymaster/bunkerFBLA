extends Node

@export var SCORE: int = 0

#called every 2 seconds
signal lights_out


@export var MIN_DEGRATION: float = 0.5 #min
@export var MAX_DEGRATION: float = 2 # max

@export var isInScenario: bool = false
@export var isInMinigame: bool = false:
	set(value):
		isInMinigame = value
		if not value:
			print("Showing gui")
			GUI.get_node("Stats").show()
		else:
			print("hiding")
			GUI.get_node("Stats").hide()

@export var HEALTH: int = 100:
	set(value):
		if value >= 100:
			value = 100
		HEALTH = value
		GUI.reapplyValues()
		
@export var HUNGER: int = 100:
	set(value):
		if value >= 100:
			value = 100
		HUNGER = value
		GUI.reapplyValues()
		
@export var THIRST: int = 100:
	set(value):
		if value >= 100:
			value = 100
		THIRST = value
		GUI.reapplyValues()

@export var TIME_ELAPSED: float = 0.0:
	set(value):
		TIME_ELAPSED = value
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
	
func _process(delta: float) -> void:
	if not isInMinigame:
		TIME_ELAPSED+=delta


func _on_degration_timer_timeout() -> void:
	if not isInMinigame:
		HEALTH-= randi_range(MIN_DEGRATION, MAX_DEGRATION)
		HUNGER-= randi_range(MIN_DEGRATION, MAX_DEGRATION)
		THIRST-= randi_range(MIN_DEGRATION, MAX_DEGRATION)
	$DegrationTimer.start()


func _on_scenario_timer_timeout() -> void:
	lights_out.emit()
	if not isInScenario and not isInMinigame:
		var scenario: Scenario = Scenario.from_json(SCENARIOS.pick_random())
		await DialogSystem.display_scenario(scenario)
		$ScenarioTimer.start()
		
		
#Settings
var BRIGHTNESS: float = 1:
	set(value):
		BRIGHTNESS = value
		$WorldEnvironment.adjustment_brightness = BRIGHTNESS
var CONTRAST: float = 1:
	set(value):
		CONTRAST = value
		$WorldEnvironment.adjustment_contrast = CONTRAST
		
var SATURATION: float = 1:
	set(value):
		SATURATION = value
		$WorldEnvironment.adjustment_saturation = SATURATION
