extends Panel

export(float) var card_spacing
export(float) var card_raise

var hovered_card


func _ready():
	var cards_in_hand = get_child_count()
	for i in range(cards_in_hand):
		var card = get_child(i)
		card.connect("mouse_entered", self, "_on_card_mouse_entered", [card])
		card.connect("mouse_exited", self, "_on_card_mouse_exited", [card])

func _process(delta):
	reorder_hand()

func reorder_hand():
	var cards_in_hand = get_child_count()
	var space_needed = cards_in_hand * card_spacing
	if hovered_card:
		# make space for hovered card
		space_needed += 255.0 * 2
	var next_pos = Vector2(rect_size.x / 2, 0.0) + Vector2(-space_needed / 2, 0.0)
	
	for i in range(cards_in_hand):
		var card = get_child(i)
		if hovered_card == card:
			next_pos += Vector2(255.0 - card_spacing, -card_raise)
			card.rect_position = next_pos
			next_pos += Vector2(255.0, card_raise)
		else:
			card.rect_position = next_pos
			next_pos += Vector2(card_spacing, 0.0)

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	data.get_parent().remove_child(data)
	data.disconnect("mouse_entered", data.get_parent(), "_on_card_mouse_entered")
	data.disconnect("mouse_exited", data.get_parent(), "_on_card_mouse_exited")
	self.add_child(data)
	data.show()
	data.connect("mouse_entered", self, "_on_card_mouse_entered", [data])
	data.connect("mouse_exited", self, "_on_card_mouse_exited", [data])
	reorder_hand()

func _on_card_mouse_entered(card):
	hovered_card = card

func _on_card_mouse_exited(card):
	if hovered_card == card:
		hovered_card = null
