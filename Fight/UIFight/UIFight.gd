extends Popup

onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
onready var PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
onready var FightSceneBG = get_node("/root/FightScene/BG")
onready var FightSceneCercle1 = get_node("/root/FightScene/BG/CerclePlayer")
onready var FightSceneCercle2 = get_node("/root/FightScene/BG/CercleEnnemi")

signal EnterTreeAnimation
signal EnterTreeChangePokemon
signal ChangePokemon
signal ChangeEnnemiPokemon
signal EnterTreeAnimation2

func _ready():
#	Load Graphic
	FightSceneBG.color = UIFight.BGCOLOR
	FightSceneCercle1.texture = UIFight.CercleFight
	FightSceneCercle2.texture = UIFight.CercleFight

func changeText(Text) :
	$Text.text = Text
	$ShowText.play("Show_Text")

func _on_UIFight_tree_entered():
	popup()
	get_node("/root/FightScene/MenuPokemon").visible = false
	Attaque.reload("Both")
#		1) Dresseur Fight
	if (UIFight.TypeOfFight == "FightDresseur") :
	#	Load Textures
		EG.loadTexture(get_node("/root/FightScene/Ennemi/Ennemi"))
	#	Animation EnterTree
		emit_signal("EnterTreeAnimation")
		yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
	#	Text
		changeText(UIFight.TxtIntro)
		yield($ShowText,"animation_finished")
		UIFight.PassTxt = false
		while(!UIFight.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
	#	Animation
		emit_signal("ChangeEnnemiPokemon")
		yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
		yield(get_tree().create_timer(0.8), "timeout")
		get_node("/root/FightScene/UIListPokemonEnnemi").hide()
		emit_signal("EnterTreeChangePokemon")
		yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
#		2) Savage
	elif (UIFight.TypeOfFight == "Savage") :
	#	Animation EnterTree
		emit_signal("EnterTreeAnimation2")
		yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
	#	Text
		changeText(UIFight.TxtIntro)
		yield($ShowText,"animation_finished")
		UIFight.PassTxt = false
		while(!UIFight.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
		emit_signal("EnterTreeChangePokemon")
		yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
#	UI pop and hide
	get_node("/root/FightScene/UIAction").popup()
#	Text UIAction
	changeText("Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?")

func _input(_event):
	if Input.is_action_pressed("ui_speack_accept") :
		if (UIFight.CantPassTxt) :
			pass
		elif ($Text.percent_visible != 1) :
			$ShowText.playback_speed = 5
		else :
			$ShowText.playback_speed = 1
			UIFight.PassTxt = true

func _on_UIFight_ChangePokemon():
	changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
func _on_UIFight_EnterTreeChangePokemon():
	changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
func _on_UIFight_ChangeEnnemiPokemon():
	changeText(EG.EnnemiName + " envoie " + PokemonEnnemi.PokemonEnnemi.Name)
