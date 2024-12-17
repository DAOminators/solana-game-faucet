extends Area3D

@onready var collider:CollisionShape3D=$Collider
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var game_manager:GameManager = get_tree().get_first_node_in_group("GameManager")
		game_manager.win_game()
		#collider.disabled=true
	
