extends XRToolsPickable


func pick_up(by: Node3D, with_controller: XRController3D) -> void:
	# Fill up the player fuel
	GameState.player_fuel = 100.0

	# Convert to rigid before picking up
	freeze = false
	
	# Start playing the glug sound (until deleted)
	$GlugSound.play()

	# Perform the pick_up
	super.pick_up(by, with_controller)

	# Schedule death in 3 seconds
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",Callable(self,"drop_and_free"))
	timer.set_wait_time(3)
	timer.start()

