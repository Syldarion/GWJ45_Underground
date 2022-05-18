class_name CardEffect
extends Resource

enum EFFECT_TARGET {
	DieOne,
	DieAll,
	Player,
	EnemyOne,
	EnemyAll
}

enum EFFECT_TYPE {
	ADD,
	SUBTRACT,
	MULTIPLY,
	SET,
	REROLL
}


export(EFFECT_TARGET) var effect_target
export(EFFECT_TYPE) var effect_type
export(String) var modified_variable
export(int) var modifier_value


func _init(e_target, e_type, variable, e_value):
	effect_target = e_target
	effect_type = e_type
	modified_variable = variable
	modified_variable = e_value
