@tool
class_name Item extends Node2D

@export var icon: CompressedTexture2D:
	set(value):
		if onready or Engine.is_editor_hint():
			icon = value
			$Icon.texture = icon
			$Tooltip.global_position = ($Icon.global_position-$Tooltip.size/2)

@export var aud: AudioStream

var db: bool = false
var onready = false
@export var supply : Dictionary = {
	"HEALTH" : 0,
	"HUNGER" : 0,
	"THIRST" : 0,
}:
	set(value):
		supply = value
		var s: String = ""
		if onready:
			for key in supply.keys():
				if supply[key] != 0:
					s+="%d %s, " % [supply[key], key]
			if s == "":
				s = "Nothing..."
			%Stats.text = "[b]%s[/b]" % s
func _ready() -> void:
	supply = supply
	onready = true



func _on_mouse_detector_mouse_entered() -> void:
	%Tooltip.show()
	


func _on_mouse_detector_mouse_exited() -> void:
	%Tooltip.hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select") and %Tooltip.visible and not db:
		db = true
		if aud:
			AudioManager.play(aud)
		for stat in supply:
			GameManager[stat] += supply[stat]
		queue_free()
