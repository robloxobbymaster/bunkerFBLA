@tool
class_name Item extends Node2D

@export var icon: CompressedTexture2D:
	set(value):
		await ready
		icon = value
		$Icon.texture = icon
		$Tooltip.global_position = ($Icon.global_position-$Tooltip.size/2)

@export var supply : Dictionary = {
	"HEALTH" : 0,
	"HUNGER" : 0,
	"THIRST" : 0,
}:
	set(value):
		await  ready
		supply = value
		var s: String = ""
		for key in supply.keys():
			if supply[key] != 0:
				s+="%d %s, " % [supply[key], key]
		if s == "":
			s = "Nothing..."
		%Stats.text = "[b]%s[/b]" % s
func _ready() -> void:
	supply = supply



func _on_mouse_detector_mouse_entered() -> void:
	%Tooltip.show()
	


func _on_mouse_detector_mouse_exited() -> void:
	%Tooltip.hide()
