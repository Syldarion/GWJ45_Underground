class_name CardData
extends Resource

enum CARD_TYPE {
	Attack,
	Defense,
	Utility
}

const card_type_icons = {
	CARD_TYPE.Attack: "res://sprites/sword.png",
	CARD_TYPE.Defense: "res://sprites/shield.png",
	CARD_TYPE.Utility: "res://sprites/hexagon.png"
}

export(String) var card_name
export(Texture) var card_image
export(CARD_TYPE) var card_type
export(String) var card_text
export(Array, Resource) var card_effects


func _init(c_name = "__CARD", c_image = null, c_type = CARD_TYPE.Attack, c_text = "", c_effects = []):
	card_name = c_name
	card_image= c_image
	card_type = c_type
	card_text = c_text
	card_effects = c_effects

func _on_card_played():
	pass
