extends Control

export(Resource) var TEST__card_data

onready var card_image = $CardImage as TextureRect
onready var card_name_label = $CardNameLabel as Label
onready var card_text_label = $CardTextLabel as Label
onready var card_type_image = $CardTypeTexture as TextureRect


func _ready():
	load_card_data(TEST__card_data)

func _gui_input(event):
	pass

func get_drag_data(position):
	var preview_parent = Control.new()
	var preview = duplicate()
	preview_parent.add_child(preview)
	preview.rect_position = -position
	set_drag_preview(preview_parent)
	
	hide()
	return self

func load_card_data(card_data: CardData):
	card_image.texture = card_data.card_image
	card_name_label.text = card_data.card_name
	card_text_label.text = card_data.card_text
	card_type_image.texture = load(CardData.card_type_icons[card_data.card_type])
