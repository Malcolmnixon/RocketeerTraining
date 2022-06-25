extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	# Show last score
	if GameState.current_score > 0:
		$MainPage/LastScoreValue.text = "%d" % [ GameState.current_score ]
	else:
		$MainPage/LastScoreValue.text = "-"

	# Show best score
	if GameState.best_score > 0:
		$MainPage/BestScoreValue.text = "%d" % [ GameState.best_score ]
	else:
		$MainPage/BestScoreValue.text = "-"


func _on_StartButton_pressed():
	GameSignals.emit_signal("game_started")


func _on_AboutButton_pressed():
	$MainPage.visible = false
	$AboutPage.visible = true


func _on_BackButton_pressed():
	$MainPage.visible = true
	$AboutPage.visible = false
