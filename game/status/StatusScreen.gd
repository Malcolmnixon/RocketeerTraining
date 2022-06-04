extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	# Show last score
	if GameState.current_score > 0:
		$LastScoreValue.text = "%d" % [ GameState.current_score ]
	else:
		$LastScoreValue.text = "-"

	# Show best score
	if GameState.best_score > 0:
		$BestScoreValue.text = "%d" % [ GameState.best_score ]
	else:
		$BestScoreValue.text = "-"


func _on_StartButton_pressed():
	GameSignals.emit_signal("game_started")
