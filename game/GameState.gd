extends Node


enum GameStage {
	AT_START,
	INTRO_SPEECH,
	FIRST_STATUS,
	SECOND_STATUS,
	LANDING,
	DEAD
}


# Game state
var player_fuel: float = 0.0
var game_stage: int = GameStage.AT_START

# Game scores
var current_score: int = 0
var best_score: int = 0
