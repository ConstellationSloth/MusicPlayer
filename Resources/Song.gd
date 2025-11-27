extends Resource
class_name Song

@export var id : int
@export var name : String
@export var artist : String
@export var album : String
@export var length : float
@export var path : String
@export var playlists : Array[int]

func set_data(
	song_name : String, 
	artist_name : String, 
	album_name : String, 
	location : String, 
	song_length: float,
	song_id : int
	):
	name = song_name
	artist = artist_name
	album = album_name
	path = location
	length = song_length
	id = song_id
