extends Node3D


# Player alive flag
var alive := true

# Get the flight movement node
@onready var flight: XRToolsMovementFlight = $"../MovementFlight"

# Get the low fuel alarm
@onready var low_fuel_alarm_sound: AudioStreamPlayer = $LowFuelAlarmSound


func _ready():
	# Connect game signals
	GameSignals.connect("game_started",Callable(self,"_on_game_started"))


func _process(delta: float):
	# Consume fuel when flying
	if flight.is_active:
		GameState.player_fuel = clamp(GameState.player_fuel - delta, 0.0, 100.0)

	# Check if we have low fuel
	var has_low_fuel := flight.is_active and GameState.player_fuel < 20.0

	# Enable or disable alarm as appropriate
	if has_low_fuel and !low_fuel_alarm_sound.playing:
		low_fuel_alarm_sound.play()
	if !has_low_fuel and low_fuel_alarm_sound.playing:
		low_fuel_alarm_sound.stop()

	# Disable flying when out of fuel
	$"../MovementFlight".enabled = GameState.player_fuel > 0
	
	# Report death by being lost
	if alive and $"../PlayerBody/CharacterBody3D".global_transform.origin.length_squared() > 300*300:
		alive = false
		GameSignals.emit_signal("death_by_lost")


func _on_game_started():
	# Disable menu control
	$"../RightHandController/FunctionPointer".enabled = false

	# Enable game control
	$"../LeftHandController/MovementDirect".enabled = true
	$"../LeftHandController/MovementJump".enabled = true
	$"../RightHandController/MovementDirect".enabled = true
	$"../RightHandController/MovementJump".enabled = true
	$"../MovementClimb".enabled = true
	$"../MovementFlight".enabled = true
	$"../MovementPhysicalJump".enabled = true
	$"../MovementGlide".enabled = true


func _on_flight_started():
	$FlightSound.play()


func _on_flight_finished():
	$FlightSound.stop()


func _on_glide_started():
	$GlideSound.play()


func _on_glide_finished():
	$GlideSound.stop()
