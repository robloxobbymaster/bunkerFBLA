@tool
class_name Item extends Node2D

@export var icon: CompressedTexture2D:
	set(value):
		icon = value
		$Icon.texture = value

@export var supply : Dictionary = {
	"HEALTH" : 0,
	"HUNGER" : 0,
	"THIRST" : 0,
}
