extends Node

enum MusicInfoType { Name, Artist, Album}
const USER_DIRECTORY = "user://"
const SONG_INFO_DIRECTORY = "user://song_info/"
const SONG_DATA_DIRECTORY = "user://song_data/"

func _ready():
	ensure_all_directories_exist()




func get_music_info_type_description(type: MusicInfoType):
	match(type):
		MusicInfoType.Name:
			return "Name"
		MusicInfoType.Artist:
			return "Artist"
		MusicInfoType.Album:
			return "Album"



func ensure_all_directories_exist():
	print("checking data directory")
	check_directory(SONG_DATA_DIRECTORY)
	print("checking info directory")
	check_directory(SONG_INFO_DIRECTORY)
	print("finished with song directories")

func check_directory(path):
	var dir_access = DirAccess.open(USER_DIRECTORY)
	if not dir_access.dir_exists(path):
		dir_access.make_dir(path)
