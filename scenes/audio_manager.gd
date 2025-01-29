extends Node

var SoundIds = {
	DIALOG = load("res://soundEffects/dialogSoundEffect.mp3")
}

func play(audio: AudioStream, volume: float = 1) -> void:
	var newSound: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	newSound.stream = audio
	newSound.volume_db = volume
	
	add_child(newSound)
	newSound.play()
	
	newSound.finished.connect(func():
		newSound.queue_free()
		)
	
	return
