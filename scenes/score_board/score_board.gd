extends Control
var score_board = {}


var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
var selectedLetterIndices = [0, 0, 0]
var selectedLetter = ['', '', '']
var letter1 = 'A'
var letter2 = 'A'
var letter3 = 'A'

var fullName

var max_entries = 7

@onready var ScoreBoardLabel = $scoreboard


func _ready():
	score_board = SaveFile.scoreboard
	
	$enter_name_label.visible = true
	$name_input.visible = true ###setting visibility#
	$background_popup.visible = true
	$buttons.visible = false
	ScoreBoardLabel.visible = false
	
	#buttonsa for input
	$name_input/HBoxContainer/column_1/next.connect("pressed", on_next_button_pressed.bind([0]))
	$name_input/HBoxContainer/column_1/prev.connect("pressed", on_prev_button_pressed.bind([0]))
	$name_input/HBoxContainer/column_2/next.connect("pressed", on_next_button_pressed.bind([1]))
	$name_input/HBoxContainer/column_2/prev.connect("pressed", on_prev_button_pressed.bind([1]))
	$name_input/HBoxContainer/column_3/next.connect("pressed", on_next_button_pressed.bind([2]))
	$name_input/HBoxContainer/column_3/prev.connect("pressed", on_prev_button_pressed.bind([2]))
	
func _process(delta):

	fullName = letter1 + letter2 + letter3
	
####-----handling scoreboard-------#######


func sort_score_board(): #pre sorting dictionary
	var sorted_keys = []
	for key in score_board.keys():
		sorted_keys.append(int(key))
	sorted_keys.sort()	
	
	var sorted_dict = {}
	for key in sorted_keys:
		sorted_dict[key] = score_board[str(key)]
	return sorted_dict

func show_label(): #showing pre sorted dictionary
	var sorted_dict = sort_score_board()
	
	var keys = sorted_dict.keys() #showing keys
	for i in range(1, 8):
		var key_label = get_node('scoreboard/CenterContainer/GridContainer/score_' + str(i))
		key_label.text = str(keys[i-1])
	
	var values = sorted_dict.values() #showing values
	for i in range(1, 8):
		var value_label = get_node('scoreboard/CenterContainer/GridContainer/player_name_' + str(i))
		value_label.text = str(values[i-1])
		
		
		
####----------inputting name------####


func on_next_button_pressed(column):
	selectNextLetter(column[0], -1)

func on_prev_button_pressed(column):
	selectNextLetter(column[0], +1)
	
func selectNextLetter(column, direction): #whatever the fuck this do. It just works 
	selectedLetterIndices[column] += direction
	selectedLetterIndices[column] = selectedLetterIndices[column] % alphabet.length()  # Wrap around the alphabet
	if selectedLetterIndices[column] < 0:
		selectedLetterIndices[column] = alphabet.length() - 1
	
	var selectedLetter = alphabet.substr(selectedLetterIndices[column], 1)
	updateUI(column, selectedLetter)
	
	letter1 = alphabet.substr(selectedLetterIndices[0], 1)
	letter2 = alphabet.substr(selectedLetterIndices[1], 1)
	letter3 = alphabet.substr(selectedLetterIndices[2], 1)
	
func updateUI(column, selectedLetter):#update every button press
	get_node('name_input/HBoxContainer/column_' + str(column + 1) + '/label_c_' + str(column + 1)).text = str(selectedLetter)
	
func saveScore():
	var player_name = fullName
	var new_score = str(global.score)
	if score_board.has(new_score):
		var existing_player = score_board[new_score]
		if player_name != existing_player:
			score_board[new_score] = player_name
	else:
		score_board[new_score] = player_name


		
func limit_scoreboard_entries():
	var scoreboard = score_board
	if scoreboard.size() > max_entries:
		var sorted_scoreboard = sort_score_board()
		var lowest_score_key = sorted_scoreboard.keys()[0]  # Get the key of the lowest score
		scoreboard.erase(lowest_score_key)  # Remove the lowest score entry



			
func _on_button_pressed():
	saveScore()
	
	limit_scoreboard_entries()
	show_label()
	
	$enter_name_label.visible = false
	$name_input.visible = false###setting visibility#
	$background_popup.visible =false
	$buttons.visible = true
	ScoreBoardLabel.visible = true
	SaveFile.save_game()
	


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/loading_screen/loading_screen.tscn")
	global.reset()


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
