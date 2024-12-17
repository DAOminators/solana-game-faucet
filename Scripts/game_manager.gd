extends Node
class_name GameManager

@export var start_price:float=20.0
@export var dump_rate:float=3.0

@export var gui:GUI

var curr_price:float

var game_active:bool=true

func _init():
	add_to_group("GameManager")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_price=start_price
	print("START")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !game_active:
		return
			
	curr_price-=delta*dump_rate
	print(curr_price)
	
	if curr_price<=0:
		curr_price=0;
		game_active=false
		lose_game()
		
func pump(amount:float)->void:
	curr_price += amount

func get_curr_price()->float:
	return curr_price

func win_game() -> void:
	game_active=false
	gui.handle_game_win(curr_price)
	
func lose_game()->void:
	gui.handle_game_lose() 
