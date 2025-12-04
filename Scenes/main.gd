extends Control


@export var playlist_list_scene : PackedScene
@export var add_song_scene : PackedScene
@export var home_scene : PackedScene
@export var playlist_scene : PackedScene

@onready var stream_player = $AudioStreamPlayer
@onready var scene_container = $PageContainer

func _ready():
	EventBus.music_uploaded.connect(on_music_upload)
	EventBus.song_added.connect(on_song_added)
	EventBus.view_playlists_selected.connect(view_playlists)
	EventBus.playlist_selected.connect(view_playlist)

func view_playlist(playlist: Playlist):
	clear_page()
	var screen = playlist_scene.instantiate()
	screen.set_playlist(playlist)
	set_page(screen)

func view_playlists():
	clear_page()
	var node = playlist_list_scene.instantiate()
	set_page(node)

func set_page(node: Node):
	clear_page()
	scene_container.add_child(node)

func on_song_added():
	var home_page = home_scene.instantiate()
	set_page(home_page)

func clear_page():
	for child in scene_container.get_children():
		child.queue_free()

func on_music_upload(path: String):
	var add_song_page : AddSong = add_song_scene.instantiate()
	add_song_page.set_path(path)
	set_page(add_song_page)
