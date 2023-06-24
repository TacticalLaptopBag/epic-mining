extends Resource
class_name Ore

enum Type {
	DIRT,
	STONE,
	IRON,
	GOLD,
	DIAMOND,
}

@export var block_type: Type
@export var display_name: String
@export_range(1, 100) var chance_of_spawn: int
@export var minimum_depth: int
@export var price: int
@export var material: Material
