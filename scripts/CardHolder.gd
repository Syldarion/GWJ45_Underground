extends Panel


func can_drop_data(position, data):
	return true

func drop_data(position, data):
	data.get_parent().remove_child(data)
	self.add_child(data)
	data.show()
