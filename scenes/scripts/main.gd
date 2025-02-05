extends Node2D

@export var darknessLVL: float = 0.85

var inDarkness: bool = false

func _ready() -> void:
	GameManager.lights_out.connect(lights_out)
	
	
func lights_out() -> void:
	%Lightbulb.play("flicker")
	await %Lightbulb.animation_finished
	%EnvLight.energy = darknessLVL
	%Lightbulb.play("hover")
	%Lightbulb.get_node("LightOccluder2D").show()
	inDarkness = true



func _on_lightbulb_frame_changed() -> void:
	if %Lightbulb.frame%2==0:
		%EnvLight.energy = darknessLVL
	else:
		%EnvLight.energy = 0
