extends Node


# Get the flight movement node
onready var flight: Function_FlightMovement = $"../Function_Flight_movement"


func _process(delta: float):
	# Consume fuel when flying
	if flight.is_active:
		GameState.player_fuel = clamp(GameState.player_fuel - delta, 0.0, 100.0)

	# Disable flying when out of fuel
	$"../Function_Flight_movement".enabled = GameState.player_fuel > 0
