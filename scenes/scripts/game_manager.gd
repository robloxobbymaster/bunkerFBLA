extends Node

@export var SCORE: int = 0
@export var HEALTH: int = 100:
	set(value):
		HEALTH = value
		GUI.HEALTH.val = value
		
@export var HUNGER: int = 100:
	set(value):
		HUNGER = value
		GUI.HUNGER.val = value
		
@export var THIRST: int = 100:
	set(value):
		THIRST = value
		GUI.THIRST.val = value
