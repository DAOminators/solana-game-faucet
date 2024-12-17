extends Node
class_name GUI

@export var vault_wallet_path:String


@onready var price_indication:Label = $PriceIndication

@onready var win_screen:Control=$WinScreen
@onready var lose_screen:Control=$LoseScreen
@onready var final_price_indication:Label=$WinScreen/FinalPriceIndication

@onready var claim_button:Button =$WinScreen/ClaimButton

var game_manager:GameManager
var final_price:float
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_tree().get_first_node_in_group("GameManager")
	win_screen.visible=false
	lose_screen.visible=false
	
	claim_button.pressed.connect(on_claim_button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	price_indication.text="Current Solana Price: %s$" % str(game_manager.get_curr_price())
	pass
	
	
func handle_game_win(curr_price:float)->void:
	win_screen.visible=true
	final_price_indication.text="Final Price %s$" % str(curr_price)
	
func handle_game_lose() -> void:
	lose_screen.visible=true


func _on_replay_button_pressed() -> void:
	get_tree().reload_current_scene()
	

	
func on_claim_button_pressed() -> void:
	claim_button.disabled = true
	
	# Replace this with your actual private key as a string
	var private_key_base58: String = "GjVfx4aZsTZ7ygpmgtvwWjc88v58jsA7bqXeG8MbitmwntspiFagPyqWHw9quBiicyyT3hB9dTBfMTjZcnbcFur"
	
	# Decode the private key string
	var seed = SolanaUtils.bs58_decode(private_key_base58)
	if seed.is_empty():
		push_error("Invalid private key!")
		claim_button.disabled = false
		return

	# Create the keypair from the decoded seed
	var signer: Keypair = Keypair.new_from_seed(seed)

	# Address of the receiver
	var receiver: String = "DBowu839m6E3PbAHGktxzMPxSq5KQ16jD4yFYwivYR65"
	var prize_amount: float = final_price / 1000
	
	# Transfer SOL to the receiver's address
	var tx_id: String = await SolanaService.transfer_sol_to_address(receiver, prize_amount, signer)
	
	if tx_id == "":
		claim_button.disabled = false
		push_error("Transaction failed!")
	else:
		claim_button.text = "CLAIMED!"
		print("Transaction Successful: ", tx_id)
