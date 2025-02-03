extends Node

@export var SCORE: int = 0
@export var HEALTH: int = GUI.HEALTH.val:
	set(value):
		HEALTH = value
		GUI.HEALTH.val = value
		
@export var HUNGER: int = GUI.HUNGER.val:
	set(value):
		HUNGER = value
		GUI.HUNGER.val = value
		
@export var THIRST: int = GUI.THIRST.val:
	set(value):
		THIRST = value
		GUI.THIRST.val = value
