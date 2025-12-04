extends VBoxContainer

@onready var dialog = $FileDialog

func _on_file_dialog_file_selected(path):
	EventBus.music_uploaded.emit(path)


func _on_upload_pressed():
	dialog.show()


func _on_playlists_pressed():
	EventBus.view_playlists_selected.emit()


func _on_song_library_pressed():
	EventBus.view_song_library_selected.emit()
