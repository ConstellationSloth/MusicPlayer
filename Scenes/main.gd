extends Control

@onready var scene_container = $PageContainer

@export_file_path("*.tscn") var home_path
@export_file_path("*.tscn") var add_song_path

@onready var stream_player = $AudioStreamPlayer

func _ready():
	EventBus.music_uploaded.connect(on_music_upload)
	EventBus.song_added.connect(on_song_added)

func set_page(node: Node):
	clear_page()
	scene_container.add_child(node)

func on_song_added():
	var home_page = load(home_path).instantiate()
	set_page(home_page)

func clear_page():
	for child in scene_container.get_children():
		child.queue_free()

func on_music_upload(path: String):
	var add_song_page : AddSong = load(add_song_path).instantiate()
	add_song_page.set_path(path)
	set_page(add_song_page)
