extends Node2D


func _process(_delay):
	$Gauge.rotation = deg_to_rad(GameState.player_fuel * 90 / 100)
