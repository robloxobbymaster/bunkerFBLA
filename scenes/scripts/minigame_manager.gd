extends Node2D

@onready var WiringMinigame: Wiring_Minigame = %WiringMinigame

@onready var minigames: Array[Node] = [
	WiringMinigame,
]

func pickMinigame() -> int:
	var minigame: Node = minigames.pick_random()
	
	if minigame == WiringMinigame:
		GameManager.lights_out.emit()
	await minigame.completed
	return 0
