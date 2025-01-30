extends NinePatchRect

const SPEED = 5

signal finishedLerp

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
	

func display(text: String = "....", displayName: String = "?????", icon: Resource = load("res://graphics/dialogSystem/mysteriousIcon.png"), typingSpeed: float = 0.15) -> int:
	_show()	
	%Dialog.text = ""
	
	%DisplayName.text = "[center]%s[/center]" % displayName
	
	%Icon.texture = icon
	
	var splittedText := text.split("")
	
	for character in splittedText:
		%Dialog.text+=character
		await get_tree().create_timer(typingSpeed/2).timeout
		AudioManager.play(AudioManager.SoundIds.DIALOG)
	
	
	
	return 0


func _ready() -> void:
	_hide()
	await get_tree().create_timer(3).timeout
	display("HEJKFL:LJSLFKLDJFSKLDFJLSJDFLKSJKLFSJKLFDJSLDFJLKJFKLJDFKLj")
	for btn in %Decisions.get_children():
		btn.connect("mouse_entered", func():
			%Hover.position.y = (btn.position.y + %Decisions.position.y + (btn.size.y/2))-(%Hover.size.y/2)
			)
	
	
func _process(delta: float) -> void:
	offset_top = lerp(offset_top, target_anchor, delta*SPEED)
	if anchor_top == target_anchor:
		finishedLerp.emit()
	offset_bottom = lerp(offset_bottom, target_anchor+anchorDiff, delta*SPEED)
