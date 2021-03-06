extends Spatial



# Preload the target scene
var fuel_scene := preload("res://game/fuel/Fuel.tscn")


onready var spawn_timer = $SpawnTimer

onready var fuel = $Fuel



func _on_fuel_picked_up(_pickable):
	fuel = null
	spawn_timer.start()


func _on_spawn_timer_timeout():
	fuel = fuel_scene.instance()
	fuel.connect("picked_up", self, "_on_fuel_picked_up")
	add_child(fuel)
