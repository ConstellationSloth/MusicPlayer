extends VBoxContainer
class_name SongList

@export var song_row_scene : PackedScene
@export var song_rows : VBoxContainer
@export var search_bar : LineEdit
signal song_selected(song: Song)



var songs = []
var shown_songs = []

# load all songs and display

func _ready():
	var song_info_dir = DirAccess.open(Globals.SONG_INFO_DIRECTORY)
	for file_name in song_info_dir.get_files():
		var song : Song = ResourceLoader.load(Globals.SONG_INFO_DIRECTORY+file_name)
		print("loaded song:", song.name)
		songs.append(song)
		shown_songs.append(song)
	add_songs()

func clear_songs():
	for child in song_rows.get_children():
		child.queue_free()

func add_songs():
	for song in shown_songs:
		var song_row : SongRow = song_row_scene.instantiate()
		song_row.set_song(song)
		song_row.song_selected.connect(on_song_selected)
		song_rows.add_child(song_row)


func on_song_selected(song : Song):
	song_selected.emit(song)


func _on_search_pressed():
	var search_text = search_bar.text
	shown_songs = []
	for song in songs:
		if search_text in song.name:
			shown_songs.append(song)
	clear_songs()
	add_songs()
