extends Node2D

@export var darknessLVL: float = 0.85

var inDarkness: bool = false

func _ready() -> void:
	GameManager.lights_out.connect(lights_out)
	GameManager.lights_on.connect(lights_on)
	await get_tree().create_timer(5).timeout
	GameManager.lights_out.emit()
	
	
func lights_out() -> void:
	%Lightbulb.play("flicker")
	await %Lightbulb.animation_finished
	%EnvLight.energy = darknessLVL
	%Lightbulb.play("hover")
	inDarkness = true

func lights_on() -> void:
	%Lightbulb.play("flicker")
	await %Lightbulb.animation_finished
	%Lightbulb.play("on")
	%EnvLight.energy = 0
	inDarkness = false

func _on_lightbulb_frame_changed() -> void:
	if %Lightbulb.frame%2==0 and %Lightbulb.animation == "flicker":
		%EnvLight.energy = darknessLVL
	elif %Lightbulb.animation == "flicker":
		%EnvLight.energy = 0
