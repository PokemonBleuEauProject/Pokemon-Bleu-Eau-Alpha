extends Control

var AcceptUiSpeack = false
var ChangeName = false
var Name
var Name2

var ActualPositionChooseRival = 0
var ChooseRival = false

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and !AcceptUiSpeack :
		AcceptUiSpeack = true

func _on_Control_tree_entered():
#	$AnimationPlayer.play("Enter")
#	yield($AnimationPlayer,"animation_finished")
#	changeText("Bien le bonjour! Bienvenue dans le monde incroyable des POKEMONS!")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Mon nom est CHEN!")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Les gens m'appellent amicalement le PROF. POKEMON!")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Ce Monde ...")
#	$AnimationPlayer.play("ShowAPokemon")
#	yield(get_tree().create_timer(2),"timeout")
#	changeText("... est peuplé de créatures appelées POKEMONS!")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Pour certains, les POKEMONS sont des animaux domestiques,")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("pour d'autres, ils sont un moyen de combattre.")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Pour ma part...")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("L'etude des POKEMONS est ma profession.")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	$AnimationPlayer.play("RecallAPokemon")
#	yield($AnimationPlayer,"animation_finished")
#	changeText("Mais avant tout, parle-moi un peu de toi.")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	$AnimationPlayer.play("ChangeCharacter")
#	yield($AnimationPlayer,"animation_finished")
#	changeText("Comment t'appelles-tu ?")
#	yield($UISpeack/ShowText,"animation_finished")
#	$LineEdit.visible = true
#	while !ChangeName :
#		yield(get_tree().create_timer(0.1),"timeout")
#	PG.PlayerName = Name
#	if Name == "1" : PG.PlayerName = "2"
#	$LineEdit.visible = false
#	changeText("Formidable ! Tu t'appelles donc " + PG.PlayerName + ".")
#	yield($UISpeack/ShowText,"animation_finished")
#	$AnimationPlayer.play("ChangeCharacter 1")
#	yield($AnimationPlayer,"animation_finished")
#	changeText("Voici mon petit-fils.")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Vous etes rivaux depuis votre tendre enfance.")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("... Heu ... C'est quoi son nom deja ?")
#	yield($UISpeack/ShowText,"animation_finished")
#	$LineEdit2.visible = true
#	while !ChooseRival :
#		yield(get_tree().create_timer(0.1),"timeout")
#	$LineEdit2.visible = false
#	EG.RivalName = Name2
#	changeText("Mais oui, bien sur que je m'en souviens, c'est " + EG.RivalName + " !")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	$AnimationPlayer.play("ChangeCharacter 2")
#	yield($AnimationPlayer,"animation_finished")
#	changeText(PG.PlayerName + "!! Ta quete des POKEMONS est sur le point de commencer!")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Un tout nouveau monde de reves d'aventures et de POKEMON t'attend!")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	while !AcceptUiSpeack :
#		yield(get_tree().create_timer(0.1),"timeout")
#	changeText("Bonne chance ! Amuse-toi !")
#	yield($UISpeack/ShowText,"animation_finished")
#	AcceptUiSpeack = false
#	$AnimationPlayer.play("LeaveScene")
#	yield($AnimationPlayer,"animation_finished")
	PG.PlayerName = "Auto"
	Save.saveGame(false)
	Save.loadGame()
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/BourgPalette/StartHouse1-Top.tscn")

func changeText(string) :
	$UISpeack/ShowText.play("ShowText")
	$UISpeack/Text.text = string

func _on_LineEdit_text_entered(new_text):
	if str(new_text) != "" or str(new_text) != " " :
		ChangeName = true
		Name = str(new_text)

func _on_LineEdit2_text_entered(new_text):
	if str(new_text) != "" or str(new_text) != " " :
		ChooseRival = true
		Name2 = str(new_text)
