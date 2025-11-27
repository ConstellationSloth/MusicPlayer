extends Node


var nextIds : NextIds
const ID_FILE_PATH = Globals.USER_DIRECTORY + "ids.tres"

func _ready():
	determine_next_ids()

func determine_next_ids():
	if FileAccess.file_exists(ID_FILE_PATH):
		nextIds = ResourceLoader.load(ID_FILE_PATH)
	else:
		var id_resource = NextIds.new()
		id_resource.next_playlist_id = 1
		id_resource.next_song_id = 1
		ResourceSaver.save(id_resource, ID_FILE_PATH)
		nextIds = id_resource

func get_next_song_id():
	var id = nextIds.next_song_id
	nextIds.next_song_id += 1
	ResourceSaver.save(nextIds, ID_FILE_PATH)
	return id

func get_next_playlist_id():
	var id = nextIds.next_playlist_id
	nextIds.next_playlist_id += 1
	ResourceSaver.save(nextIds, ID_FILE_PATH)
	return id
