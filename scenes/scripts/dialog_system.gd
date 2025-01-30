extends NinePatchRect

const SPEED = 5

signal finishedLerp
signal decisionMade

@onready var anchorDiff = anchor_bottom - anchor_top
var shown_anchor: float = 0
@onready var hidden_anchor: float = size.y
var target_anchor: float = hidden_anchor #THIS IS FOR TOP ANCHOR
var queue = [];

func _show() -> int:
	target_anchor = shown_anchor
	await finishedLerp
	return 1

func _hide():
	target_anchor = hidden_anchor
	

func display(text: String = "....", displayName: String = "?????", icon: Resource = load("res://graphics/dialogSystem/mysteriousIcon.png"), closeOnDialogFinish: bool = true, typingSpeed: float = 0.15) -> int:
	_show()	
	%Dialog.text = ""
	
	%DisplayName.text = "[center]%s[/center]" % displayName
	
	%Icon.texture = icon
	
	var splittedText := text.split("")
	
	for character in splittedText:
		%Dialog.text+=character
		await get_tree().create_timer(typingSpeed/2).timeout
		AudioManager.play(AudioManager.SoundIds.DIALOG)
	
	if closeOnDialogFinish:
		await get_tree().create_timer(3).timeout
		_hide()
	

	
	return 0

func display_scenario(scenario: Scenario, displayName: String = "?????", icon: Resource = load("res://graphics/dialogSystem/mysteriousIcon.png"), typingSpeed: float = 0.15) -> int:
	
	
	var db := false
	
	for node in %Decisions.get_children(): node.queue_free()
	for key in scenario.choices.keys():
		var choice = scenario.choices[key]
		var choiceBTN: Button = %TEMPLATEBTN.duplicate()
		choiceBTN.text = choice["TITLE"]
		choiceBTN.connect("mouse_entered", func():
			%Hover.position.y = (choiceBTN.position.y + %Decisions.position.y + (choiceBTN.size.y/2))-(%Hover.size.y/2)
			)
		choiceBTN.pressed.connect(func():
			if not db:
				db = true
				await get_tree().create_timer(scenario.reveal).timeout
				display(scenario.determineOutcome(key), displayName, icon, true, typingSpeed)
				decisionMade.emit()
			)
		%Decisions.add_child(choiceBTN)
	
	display(scenario["TITLE"], displayName, icon, false, typingSpeed)
	
	await decisionMade
	_hide()
	return 0


func _ready() -> void:
	_hide()
	await get_tree().create_timer(3).timeout
	display("HEJKFL:LJSLFKLDJFSKLDFJLSJDFLKSJKLFSJKLFDJSLDFJLKJFKLJDFKLj")

	
	
func _process(delta: float) -> void:
	offset_top = lerp(offset_top, target_anchor, delta*SPEED)
	if anchor_top == target_anchor:
		finishedLerp.emit()
	offset_bottom = lerp(offset_bottom, target_anchor+anchorDiff, delta*SPEED)
