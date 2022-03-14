extends Node2D


func _process(_delay):
	$Gauge.rotation_degrees = GameState.player_fuel * 90 / 100
