extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect signals
	GameSignals.connect("game_started",Callable(self,"_on_game_started"))
	GameSignals.connect("game_finished",Callable(self,"_on_game_finished"))
	GameSignals.connect("player_entered_cabin",Callable(self,"_on_player_entered_cabin"))
	GameSignals.connect("death_by_lost",Callable(self,"_on_death_by_lost"))
	GameSignals.connect("target_passed",Callable(self,"_on_target_passed"))


func _on_game_started():
	# Clear the current score
	GameState.player_fuel = 0.0
	GameState.current_score = 0
	
	# Queue the freeing of the status screen
	$StatusScreen.queue_free()
	
	# Play the intro speech
	GameState.game_stage = GameState.GameStage.INTRO_SPEECH
	$GameSounds/IntroSpeech.play()


func _on_game_finished():
	# Update best score
	if GameState.current_score > GameState.best_score:
		GameState.best_score = GameState.current_score

	# Restart the game
	GameState.game_stage = GameState.GameStage.AT_START
	get_tree().reload_current_scene()


func _on_death_by_lost():
	# Restart the game
	GameState.game_stage = GameState.GameStage.AT_START
	get_tree().reload_current_scene()
	

func _on_target_passed():
	# Increment game score
	GameState.current_score += 1
	$GameSounds/TargetPassed.play()


func _on_player_entered_cabin():
	if GameState.game_stage == GameState.GameStage.LANDING:
		GameSignals.emit_signal("game_finished")


func _on_IntroSpeech_finished():
	# Spawn targets
	$TargetSpawn.enabled = true
	
	# Start the game action timer
	$GameActionTimer.start(60)


func _on_GameActionTimer_timeout():
	match GameState.game_stage:
		GameState.GameStage.INTRO_SPEECH:
			GameState.game_stage = GameState.GameStage.FIRST_STATUS
			$GameSounds/FirstStatus.play()
			$GameActionTimer.start(60)
		
		GameState.GameStage.FIRST_STATUS:
			GameState.game_stage = GameState.GameStage.SECOND_STATUS
			$GameSounds/SecondStatus.play()
			$GameActionTimer.start(60)

		GameState.GameStage.SECOND_STATUS:
			GameState.game_stage = GameState.GameStage.LANDING
			$TargetSpawn.enabled = false
			$TargetSpawn.clear_targets()
			$GameSounds/LandingSpeech.play()
