extends Node3D

@export var pump_amount: float=10.0
@export var spin_power:float=4.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(delta*spin_power)
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var game_manager:GameManager = get_tree().get_first_node_in_group("GameManager")
		game_manager.pump(pump_amount)
		queue_free()
