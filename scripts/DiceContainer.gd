extends CenterContainer

signal slot_selected

export(int) var slot_count
export(PackedScene) var slot_scene

onready var slot_container = $DieSlots

var slots = []

func _init(slots=1):
	slot_count = slots

func _ready():
	create_slots()

func create_slots():
	for i in range(slot_count):
		var new_slot = slot_scene.instance()
		new_slot.name = "DieSlot%d" % [i]
		slot_container.add_child(new_slot)
		new_slot.connect("slot_clicked", self, "_on_slot_clicked", [i])
		slots.append(new_slot)

func remove_die_at_index(index):
	slots[index].clear_slot()

func add_new_die(die_value):
	var free_slot = get_free_slot()
	if free_slot == null:
		return false
	free_slot.die_value = die_value
	return true

func add_random_die():
	var free_slot = get_free_slot()
	if free_slot == null:
		return false
	free_slot.roll_to_value((randi() % 6) + 1)
	return true

func get_free_slot():
	for i in range(slot_count):
		if slots[i].slot_free():
			return slots[i]
	return null

func _on_slot_clicked(slot_index):
	var slot_value = slots[slot_index].die_value
	print(slot_value)
	emit_signal("slot_selected", slot_index, slot_value)
