extends Control

var is_shown: bool = false:
	set(value):
		is_shown = value
		visible = is_shown
		if value: 
			GameManager.pause()
		else:
			GameManager.resume()


func _on_resume_btn_pressed() -> void:
	is_shown = false
	
func _on_options_btn_pressed() -> void:
	GUI.get_node("Settings")._show()
	
	
func _on_quit_btn_pressed() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escapePanel"):
		if GUI.get_node("Settings").visible:
			GUI.get_node("Settings").hide()
		else:
			is_shown = not is_shown
