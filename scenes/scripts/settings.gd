extends Control

@onready var worldEnv: Environment = GlobalWorldEnvironment.environment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ContrastSlider.value = worldEnv.adjustment_contrast
	%BrightnessSlider.value = worldEnv.adjustment_brightness
	%SaturationSlider.value = worldEnv.adjustment_saturation

func _show():
	self.show()

func _on_contrast_slider_value_changed(value: float) -> void:
	worldEnv.adjustment_contrast = value


func _on_brightness_slider_value_changed(value: float) -> void:
	worldEnv.adjustment_brightness = value


func _on_saturation_slider_value_changed(value: float) -> void:
	worldEnv.adjustment_saturation = value


func _on_close_btn_pressed() -> void:
	self.hide()
	GameManager.isInMinigame = false
