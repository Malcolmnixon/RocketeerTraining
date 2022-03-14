extends Spatial


# Get the flight movement node
onready var flight: Function_FlightMovement = $"../Function_Flight_movement"

# Get the low fuel alarm
onready var low_fuel_alarm_sound: AudioStreamPlayer3D = $LowFuelAlarmSound


func _process(_delta):
	# Check if we have low fuel
	var has_low_fuel := flight.is_active and GameState.player_fuel < 20.0

	# Enable or disable alarm as appropriate
	if has_low_fuel and !low_fuel_alarm_sound.playing:
		low_fuel_alarm_sound.play()
	if !has_low_fuel and low_fuel_alarm_sound.playing:
		low_fuel_alarm_sound.stop()


func _on_flight_started():
	$FlightSound.play()


func _on_flight_finished():
	$FlightSound.stop()


func _on_glide_started():
	$GlideSound.play()


func _on_glide_finished():
	$GlideSound.stop()
