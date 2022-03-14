extends Spatial


## Signal indicating target has passed
signal target_passed()


# Random number generator for target creation
var random = RandomNumberGenerator.new()

# Preload the target scene
var target_scene := preload("res://game/target/Target.tscn")


func _ready():
	# Scramble the random number generator
	random.randomize()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Ensure 10 targets are visible
	if get_tree().get_nodes_in_group("target").size() < 10:
		_spawn_target()

# Spawn a new target
func _spawn_target():
	# Select the target information
	var pos := Vector3.ZERO
	while true:
		pos.x = random.randf_range(-100.0, 100.0)
		pos.y = random.randf_range(-30.0, 80.0)
		pos.z = random.randf_range(-100.0, 100.0)
		if pos.length_squared() > 50*50:
			break

	var roty: float = random.randf_range(0.0, 2*PI)
	
	# Create a new target
	var target = target_scene.instance()
	target.transform = Transform(Basis(Vector3.UP, roty), pos)
	
	target.connect("target_passed", self, "_on_target_passed")
	
	# Add the target
	add_child(target)
	
func _on_target_passed():
	emit_signal("target_passed")
	$SuccessSound.play()
