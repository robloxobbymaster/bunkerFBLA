extends Node

@export var SCORE: int = 0
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
