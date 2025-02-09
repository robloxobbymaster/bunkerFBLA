@tool
class_name Item extends Node2D

@export var icon: CompressedTexture2D:
	set(value):
		icon = value
		$Icon.texture = value
		$Tooltip.global_position = ($Icon.position-$Tooltip.size/2)

@export var supply : Dictionary = {
	"HEALTH" : 0,
	"HUNGER" : 0,
	"THIRST" : 0,
}
