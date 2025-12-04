extends ColorRect

@onready var name_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer/LineEdit

func _ready():
	hide()
	EventBus.create_new_playlist_pressed.connect(on_create_new_pressed)

func on_create_new_pressed():
	name_edit.text = ""
	show()

func _on_button_pressed():
	hide()

func _on_create_pressed():
	var playlist = Playlist.new()
	playlist.name = name_edit.text
	playlist.id = IdController.get_next_playlist_id()
	PlaylistPlayer.add_playlist(playlist)
	hide()
