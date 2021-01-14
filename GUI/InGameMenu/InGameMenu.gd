extends Popup

var already_paused
var selected_menu

func change_menu_color():
	$Reprendre.color = Color.whitesmoke
	$Sauvegarder.color = Color.whitesmoke
	$Option.color = Color.whitesmoke
	$MenuPrincipal.color = Color.whitesmoke
	
	match selected_menu:
		0:
			$Reprendre.color = Color.greenyellow
		1:
			$Sauvegarder.color = Color.greenyellow
		2:
			$Option.color = Color.greenyellow
		3:
			$MenuPrincipal.color = Color.greenyellow

func _input(_event):
	if not visible:
		if Input.is_action_just_pressed("ui_cancel"):
			# Pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			popup_centered()
	else:
		if Input.is_action_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 4;
			change_menu_color()
		elif Input.is_action_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 3
			change_menu_color()
		elif Input.is_action_just_pressed("ui_accept"):
			match selected_menu:
				0:
					#Reprendre
					if not already_paused:
						get_tree().paused = false
					hide()
				1:
					pass #TODO
				2:
					pass #TODO
				3:
					#Main Menu
					get_tree().change_scene("res://GUI/StartMenu/Menu.tscn")
					get_tree().paused = false
