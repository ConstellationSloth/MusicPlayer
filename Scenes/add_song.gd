extends Control
class_name AddSong
@onready var info_holder : VBoxContainer = $AddSong/InfoHolder
@onready var name_row : UploadMusicInfoRow = $AddSong/InfoHolder/Name
@onready var artist_row : UploadMusicInfoRow = $AddSong/InfoHolder/Artist
@onready var album_row : UploadMusicInfoRow = $AddSong/InfoHolder/Album

var upload_path = ""
func set_path(path):
	upload_path = path

func get_file_name(path):
	var extension_removed = path.split(".mp3")[0]
	# get the file name
	return extension_removed.split("/")[-1]
	

func _ready():
	name_row.set_info(get_file_name(upload_path))

func add_song():
	var song_name = name_row.get_info()
	var artist = artist_row.get_info()
	var album = album_row.get_info()
	var audio_stream = get_audio_stream(upload_path)
	var new_song = Song.new()
	var song_id = IdController.get_next_song_id()
	var location = Globals.SONG_DATA_DIRECTORY+song_name+".tres"
	ResourceSaver.save(audio_stream, location)
	new_song.set_data(song_name, artist, album, location, audio_stream.get_length(), song_id)
	ResourceSaver.save(new_song, Globals.SONG_INFO_DIRECTORY+str(song_id)+".tres")
	EventBus.song_added.emit()


func get_audio_stream(path) -> AudioStreamMP3:
	var file = FileAccess.open(path, FileAccess.ModeFlags.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound


func _on_add_pressed():
	add_song()
