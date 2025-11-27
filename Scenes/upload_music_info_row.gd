extends HBoxContainer
class_name UploadMusicInfoRow

@export var type: Globals.MusicInfoType

@onready var label : Label = $Label
@onready var lineEdit : LineEdit = $LineEdit

func _ready():
	label.text = Globals.get_music_info_type_description(type)

func get_info():
	return lineEdit.text

func set_info(info):
	lineEdit.text = info
