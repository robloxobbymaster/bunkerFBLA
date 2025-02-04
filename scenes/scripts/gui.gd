extends CanvasLayer


func reapplyValues() -> void:
	%Health.value = GameManager.HEALTH
	%Hunger.value = GameManager.HUNGER
	%Thirst.value = GameManager.THIRST
