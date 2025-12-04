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
		songs[song_info.id] = song_info
		var song_row = song_row_scene.instantiate()
		song_row.set_song(song_info)
		song_container.add_child(song_row)

func set_playlist(playlist_to_set: Playlist):
	playlist = playlist_to_set

func _on_play_pressed():
	#turn the songs into a list
	var songs_to_play = []
	for song_id in playlist.songs:
		songs_to_play.append(songs[song_id])
	PlaylistPlayer.play_songs(songs_to_play)
	
	# send all the song info to playlist player
	pass # Replace with function body.
