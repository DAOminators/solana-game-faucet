extends Control

@export var game_scn:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	if SolanaService.wallet.is_connected("on_logged_in", load_game) == false:
		SolanaService.wallet.connect("on_logged_in", load_game)




func _on_connect_button_pressed() -> void:
	SolanaService.wallet.try_login()
	print("Connect button pressed.")  # Debug line
	get_tree().change_scene_to_packed(game_scn)


func load_game(success: bool) -> void:
	if success:
		get_tree().change_scene_to_packed(game_scn)
	else:
		print("Failed to load game, login unsuccessful.")
