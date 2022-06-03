extends Spatial


## Signal indicating target has passed
signal target_passed()


# Spawn enabled flag
var enabled := false

# Random number generator for target creation
var random = RandomNumberGenerator.new()

# Preload the target scene
var target_scene := preload("res://game/target/Target.tscn")


func _ready():
	# Scramble the random number generator
	random.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Skip if spawning not enabled
	if !enabled:
		return

	# Ensure 10 targets are visible
	if get_tree().get_nodes_in_group("target").size() < 10:
		_spawn_target()


# Called to clear the targets
func clear_targets():
	# Free all targets
	for t in get_tree().get_nodes_in_group("target"):
		t.queue_free()


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
	
	# Add the target
	add_child(target)
