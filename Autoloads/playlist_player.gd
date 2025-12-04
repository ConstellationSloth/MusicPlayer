extends Node


const PLAYLISTS_DIRECTORY_PATH = Globals.USER_DIRECTORY+"/playlists"
var playlist_dictionary : Dictionary[int,Playlist]
@onready var audio_stream = $AudioStreamPlayer
var songs_to_play = []
var playing_song : Song
func _ready():
	print("starting the playlist directory check")
	Globals.check_directory(PLAYLISTS_DIRECTORY_PATH)
	print("finished checking playlists")
	load_playlists()
	audio_stream.finished.connect(play_next_song)

func play_next_song():
	if (len(songs_to_play) == 0):
		print("NO SONGS LEFT TO PLAY")
		return
	var song = songs_to_play.pop_front()
	playing_song = song
	load_song_stream(song)

func load_song_stream(song: Song):
	var stream : AudioStreamMP3 = ResourceLoader.load(song.path)
	audio_stream.stream = stream
	audio_stream.play()


func load_playlists():
	print("starting the loading of playlists")
	var playlist_dir = DirAccess.open(PLAYLISTS_DIRECTORY_PATH)
	for file_name in playlist_dir.get_files():
		var playlist = ResourceLoader.load(PLAYLISTS_DIRECTORY_PATH+"/"+file_name)
		playlist_dictionary[playlist.id] = playlist
		print("just finished loading a playlist")
	print("loaded all playlists")

func play_songs(song_info_list : Array[Song]):
	songs_to_play = song_info_list
	play_next_song()
	

func add_playlist(playlist: Playlist):
	playlist_dictionary[playlist.id] = playlist
	EventBus.playlist_created.emit(playlist)
	ResourceSaver.save(playlist, PLAYLISTS_DIRECTORY_PATH+"/"+str(playlist.id)+".tres")
