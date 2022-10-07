extends Node3D


## Signal indicating a target has been passed through
signal target_passed()


# Flag indicating player is in the entrance
var _player_entrance := false


func _on_entrance_area_entered(_spatial):
	_player_entrance = true


func _on_entrance_area_exited(_spatial):
	_player_entrance = false


func _on_exit_area_entered(_spatial):
	if _player_entrance:
		GameSignals.emit_signal("target_passed")
		queue_free()
