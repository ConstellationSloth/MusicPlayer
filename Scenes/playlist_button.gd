extends Button


@onready var name_label : Label = $PlaylistRow/Name
@onready var song_count : Label = $PlaylistRow/SongCount
@onready var length : Label = $PlaylistRow/Length
var playlist : Playlist

func _ready():
	name_label.text = playlist.name
	song_count.text = str(len(playlist.songs))
	# calculate length in minutes/seconds/hours
	var seconds = int(playlist.length) % 60
	var minutes = int(playlist.length / 60) % 60
	var hours = int(playlist.length / 3600)
	var length_string = ""
	if hours > 0:
		length_string += str(hours) + ":"
	length_string += "%2d:%2d" % [minutes,seconds]
	length.text = length_string


func _on_pressed():
	EventBus.playlist_selected.emit(playlist)
