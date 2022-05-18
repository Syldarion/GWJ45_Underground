extends Control

onready var source_die_container = $DiceContainer
onready var dest_die_container = $DiceContainer2


func _ready():
	source_die_container.connect("slot_selected", self, "_on_source_slot_selected")
	dest_die_container.connect("slot_selected", self, "_on_dest_slot_selected")
	
	source_die_container.add_random_die()
	source_die_container.add_random_die()
	source_die_container.add_random_die()

func _on_source_slot_selected(index, value):
	source_die_container.remove_die_at_index(index)
	dest_die_container.add_new_die(value)

func _on_dest_slot_selected(index, value):
	dest_die_container.remove_die_at_index(index)
	source_die_container.add_new_die(value)
