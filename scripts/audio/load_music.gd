extends Node

var song: AudioStreamPlayer = null

func play_music():
	if song == null:
		song = AudioStreamPlayer.new()
		add_child(song)
		song.stream = load("res://assets/sfx/music/Sukad.mp3")
		song.play()

func stop_music():
	if song.playing:
		song.stop()
