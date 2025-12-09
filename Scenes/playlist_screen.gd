extends VBoxContainer

@export var name_label : Label
@export var name_line_edit : LineEdit
@export var confirmation_dialog : ConfirmationDialog
@export var song_row_scene : PackedScene
@export var song_container : VBoxContainer
var playlist: Playlist
var songs = {}

func _ready():
	for song_id in playlist.songs:
		#load song info
		var song_info : Song = ResourceLoader.load(Globals.SONG_INFO_DIRECTORY+str(song_id)+".tres")
		print('song name:', song_info.name)
		songs[song_info.id] = song_info
		var song_row : SongRow = song_row_scene.instantiate()
		song_row.set_song(song_info)
		#TODO: connect to song selected signal
		song_row.song_selected.connect(on_song_selected)
		song_container.add_child(song_row)

func on_song_selected(song: Song):
	#if shuffle, make the shuffle with this song in first position
	#if not, make the whole playlist, then go through and remove the songs before the one selected
	var songs_to_play = get_all_playlist_songs()
	var indexes_to_remove = []
	for idx in range(len(songs_to_play)):
		var song_info = songs_to_play[idx]
		if song_info.id != song.id:
			indexes_to_remove.append(idx)
		else:
			break
	indexes_to_remove.reverse()
	for idx in indexes_to_remove:
		songs_to_play.remove_at(idx)
	PlaylistPlayer.play_songs(songs_to_play)

func get_all_playlist_songs() -> Array[Song] :
	var songs_to_play: Array[Song] = []
	for song_id in playlist.songs:
		songs_to_play.append(songs[song_id])
	return songs_to_play

func set_playlist(playlist_to_set: Playlist):
	playlist = playlist_to_set

func _on_play_pressed():
	#turn the songs into a list
	var songs_to_play: Array[Song] = get_all_playlist_songs()
	PlaylistPlayer.play_songs(songs_to_play)
	
