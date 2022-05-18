extends TextureRect

signal slot_clicked
signal die_value_changed

export(Texture) var empty_slot_texture
export(Array, Texture) var die_textures

var die_value setget set_die_value, get_die_value
var slot_locked = false


func _ready():
	texture = empty_slot_texture
	die_value = 0

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and not slot_locked and not slot_free():
		emit_signal("slot_clicked")

func set_die_value(value: int):
	if value < 0 or value > 6:
		print_debug("WARNING: set_die_value received value [%d]" % [value])
		return
	die_value = value
	update_die_texture()
	emit_signal("die_value_changed", value)

func get_die_value() -> int:
	return die_value

func clear_slot():
	set_die_value(0)

func slot_free():
	return die_value == 0

func update_die_texture():
	if die_value >= 1 and die_value <= 6:
		texture = die_textures[die_value - 1]
	else:
		texture = empty_slot_texture

func roll_to_value(value, steps=10, start_step_wait=0.05, stop_step_wait=0.15):
	slot_locked = true
	var step_wait = start_step_wait
	var step_decay = (stop_step_wait - start_step_wait) / steps
	for i in range(steps):
		# re-roll for a new value just for nicer visuals
		var next_val = _random_die_value()
		while next_val == die_value:
			next_val = _random_die_value()
		set_die_value(next_val)
		yield(get_tree().create_timer(step_wait), "timeout")
		step_wait += step_decay
	set_die_value(value)
	slot_locked = false

func _random_die_value():
	return (randi() % 6) + 1
