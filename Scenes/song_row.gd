extends Button
class_name SongRow

@onready var name_label = $HBoxContainer/Name
@onready var length = $HBoxContainer/Length

var song : Song
signal song_selected(song: Song)

func set_song(song_to_set : Song):
	song = song_to_set

func _ready():
	var seconds = int(song.length) % 60
	var minutes = int(song.length / 60)
	length.text = "%d:%2d" % [minutes,seconds]
	name_label.text = song.name


func _on_pressed():
	song_selected.emit(song)
