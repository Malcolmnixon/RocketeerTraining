extends XRToolsPickable


func pick_up(by: Spatial, with_controller: ARVRController) -> void:
	# Fill up the player fuel
	GameState.player_fuel = 100.0

	# Convert to rigid before picking up
	mode = RigidBody.MODE_RIGID
	
	# Start playing the glug sound (until deleted)
	$GlugSound.play()

	# Perform the pick_up
	.pick_up(by, with_controller)

	# Schedule death in 3 seconds
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "drop_and_free")
	timer.set_wait_time(3)
	timer.start()

