extends Control

@export_file_path var playlist_button_path
@onready var playlist_button_scene = load(playlist_button_path)
@onready var playlist_vbox = $VBoxContainer/ScrollContainer/Playlists


func _ready():
	for key in PlaylistPlayer.playlist_dictionary.keys():
		var playlist = PlaylistPlayer.playlist_dictionary[key]
		add_playlist(playlist)
	EventBus.playlist_created.connect(add_playlist)

func add_playlist(playlist: Playlist):
	var playlist_button = playlist_button_scene.instantiate()
	playlist_button.playlist = playlist
	playlist_vbox.add_child(playlist_button)


func _on_create_new_pressed():
	EventBus.create_new_playlist_pressed.emit()
