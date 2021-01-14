extends ColorRect

#VAR NODE
var MenuPokemonScene
var player
onready var NodeTextureSelection

#VAR SELECTION
var ActualSection
var ActualTextureSelection = ""
var ActualObject = ""
var UseObjectInFight = false

#SIGNAL
signal catchapokemon(PokeballBonus,PokeballName)

func _ready():
	loadValues()
	$InformationText.text = ""
	ActualSection = "Medicaments"
	$MedicamentBox.visible = true
	$AnimationPlayer.play("IdleArrows")
	if PG.ActualScene == "/root/FightScene" : var MenuPokemonScene = get_node("/root/FightScene/MenuPokemon")
	else : MenuPokemonScene = get_node(PG.ActualScene + "/GUITotal/MenuPokemon")
	if PG.ActualScene != "/root/FightScene" : player = get_node(PG.ActualScene + "/Player")

#IMPORTANT BUTTONS
func _on_ArrowLeft_pressed():
	loadValues()
	$InformationText.text = ""
	match ActualSection :
		null,"" :
			$MedicamentBox.visible = true
			ActualSection = "Medicaments"
		"Medicaments" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$MedicamentBox.visible = false
			$ObjectBox.visible = true
			ActualSection = "Object"
		"Object" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagRight.png")
			$ObjectBox.visible = false
			$PokeballBox.visible = true
			ActualSection = "Pokeball"
		"Pokeball" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagMiddle.png")
			$PokeballBox.visible = false
			$RareObjectBox.visible = true
			ActualSection = "RareObject"
		"RareObject" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$MedicamentBox.visible = true
			$RareObjectBox.visible = false
			ActualSection = "Medicaments"
func _on_ArrowRight_pressed():
	loadValues()
	$InformationText.text = ""
	match ActualSection :
		"Medicaments" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagMiddle.png")
			$MedicamentBox.visible = false
			$RareObjectBox.visible = true
			ActualSection = "RareObject"
		"RareObject" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagRight.png")
			$RareObjectBox.visible = false
			$PokeballBox.visible = true
			ActualSection = "Pokeball"
		"Pokeball" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$ObjectBox.visible = true
			$PokeballBox.visible = false
			ActualSection = "Object"
		"Object" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$ObjectBox.visible = false
			$MedicamentBox.visible = true
			ActualSection = "Medicaments"
func _on_SortirButton_pressed():
	loadValues()
	$InformationText.text = ""
	$AnimationPlayer.stop()
	$AnimationPlayer.play("IdleArrows")
	NodeTextureSelection.modulate = Color.white
	$ChoicePopup.hide()
func _on_UtiliserButton_pressed():
#	NOT IN FIGHT
	if (!UseObjectInFight) :
		match ActualObject :
			"Potion","SuperPotion","HyperPotion","Guerison","MaxPotion","Antidote","AntiPara","Reveil","AntiBrule","TotalSoin","MaxHuile","Huile","Eau","Soda","Limonade","Lait" :
				RepeatUse1()
			"Pokeball","SuperBall","HyperBall","ChronoBall","FiletBall","FaibloBall","MasterBall" :
				pass
			"Carte" :
				pass
			"ChaussuresDeCourse" :
				if (PG.IsShoesEquip) :
					PG.IsShoesEquip = false
					player.MOTION_SPEED = 2
				else :
					PG.IsShoesEquip = true
					player.MOTION_SPEED = 3
				quit_scene()
#	IN FIGHT
	elif (UseObjectInFight) :
		match ActualObject :
			"Potion","SuperPotion","HyperPotion","Guerison","MaxPotion","Antidote","AntiPara","Reveil","AntiBrule","TotalSoin","MaxHuile","Huile","Eau","Soda","Limonade","Lait" :
				RepeatUse1()
			"Pokeball","SuperBall","HyperBall","ChronoBall","FiletBall","FaibloBall","MasterBall" :
				if UIFight.TypeOfFight == "FightDresseur" :
					pass
				else :
					match ActualObject :
						"Pokeball" :
							CatchAPokemonInFight(1,ActualObject)
						"MasterBall" :
							CatchAPokemonInFight(255,ActualObject)
			"Carte" :
				pass
			"ChaussuresDeCourse" :
				pass
func _on_JeterButton_pressed():
	if (!UseObjectInFight) :
		match ActualSection :
			"RareObject" :
				pass
			_ :
				$JeterPopup.popup()
	elif (UseObjectInFight) :
		pass
func _on_OutsideButton_pressed():
	quit_scene()
	if PG.ActualScene == "/root/FightScene" :
		get_node("/root/FightScene/UIAction").Cantmove = false
		get_node("/root/FightScene/UIFight").popup()
		get_node("/root/FightScene/UIAction").popup()
		get_node("/root/FightScene/UIPokemonBox").popup()
		get_node("/root/FightScene/UIPokemonBoxEnnemi").popup()
func _on_LineEdit_text_entered(new_text):
	if (int(new_text)) :
		var temp : int = 0
		temp = GetDictionnaryValue(ActualObject)
		if temp < int(new_text) :
			$JeterPopup/LineEdit.text = "Trop Grand !"
		elif int(new_text) < 0 :
			$JeterPopup/LineEdit.text = "Erreur !"
		else :
			match ActualObject :
				"Potion" :
					PG.AllObject["NumberObject"].NumberPotion -= int(new_text)
				"SuperPotion" :
					PG.AllObject["NumberObject"].NumberSuperPotion-= int(new_text)
				"HyperPotion" :
					PG.AllObject["NumberObject"].NumberHyperPotion-= int(new_text)
				"MaxPotion" :
					PG.AllObject["NumberObject"].NumberMaxPotion-= int(new_text)
				"Guerison" :
					PG.AllObject["NumberObject"].NumberGuerison-= int(new_text)
				"Rappel" :
					PG.AllObject["NumberObject"].NumberRappel-= int(new_text)
				"RappelMax" :
					PG.AllObject["NumberObject"].NumberRappelMax-= int(new_text)
				"Antidote" :
					PG.AllObject["NumberObject"].NumberAntidote-= int(new_text)
				"AntiPara" :
					PG.AllObject["NumberObject"].NumberAntiPara-= int(new_text)
				"AntiBrule" :
					PG.AllObject["NumberObject"].NumberAntiBrule-= int(new_text)
				"Reveil" :
					PG.AllObject["NumberObject"].NumberReveil-= int(new_text)
				"TotalSoin" :
					PG.AllObject["NumberObject"].NumberTotalSoin-= int(new_text)
				"Elixir" :
					PG.AllObject["NumberObject"].NumberElixir-= int(new_text)
				"MaxElixir" :
					PG.AllObject["NumberObject"].NumberMaxElixir-= int(new_text)
				"Huile" :
					PG.AllObject["NumberObject"].NumberHuile -= int(new_text)
				"MaxHuile" :
					PG.AllObject["NumberObject"].NumberMaxHuile -= int(new_text)
				"Eau" :
					PG.AllObject["NumberObject"].NumberEau -= int(new_text)
				"Soda" :
					PG.AllObject["NumberObject"].NumberSoda -= int(new_text)
				"Limonade" :
					PG.AllObject["NumberObject"].NumberLimonade -= int(new_text)
				"Lait" :
					PG.AllObject["NumberObject"].NumberLait -= int(new_text)
				"Pokeball" :
					PG.AllObject["NumberObject"].NumberPokeball -= int(new_text)
				"SuperBall" :
					PG.AllObject["NumberObject"].NumberSuperBall -= int(new_text)
				"HyperBall" :
					PG.AllObject["NumberObject"].NumberHyperBall -= int(new_text)
				"ChronoBall" :
					PG.AllObject["NumberObject"].NumberChronoBall -= int(new_text)
				"FiletBall" :
					PG.AllObject["NumberObject"].NumberFiletBall -= int(new_text)
				"FaibloBall" :
					PG.AllObject["NumberObject"].NumberFaibloBall -= int(new_text)
				"MasterBall" :
					PG.AllObject["NumberObject"].NumberMasterBall -= int(new_text)
				"CordeDeSortie" :
					PG.AllObject["NumberObject"].NumberCordeDeSortie -= int(new_text)
				"Repousse" :
					PG.AllObject["NumberObject"].NumberRepousse -= int(new_text)
				"SuperRepousse" :
					PG.AllObject["NumberObject"].NumberSuperRepousse -= int(new_text)
			$JeterPopup.hide()
		loadValues()
	else :
		$JeterPopup/LineEdit.text = "Erreur !"

func AnimateSelectChoice() :
	NodeTextureSelection.modulate = Color.white
	yield(get_tree().create_timer(0.2),"timeout")
	NodeTextureSelection.modulate = Color.black
	yield(get_tree().create_timer(0.1),"timeout")
	NodeTextureSelection.modulate = Color.white

#OTHERS BUTTON
#Chaque boutons pressés s'affichent, load la variable ActualObject et affiche un texte
#Medicaments
func _on_Potion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Potion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Potion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 20 PV d'un Pokemon")
		ActualObject = "Potion"
func _on_SuperPotion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/SuperPotion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/SuperPotion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 50 PV d'un Pokemon")
		ActualObject = "SuperPotion"
func _on_HyperPotion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/HyperPotion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/HyperPotion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 200 PV d'un Pokemon")
		ActualObject = "HyperPotion"
func _on_MaxPotion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/MaxPotion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/MaxPotion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure tous les PV d'un Pokemon")
		ActualObject = "MAxPotion"
func _on_Guerison_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Guerison"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Guerison"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure tous les PV d'un Pokémon et soigne tous ses problèmes de statut")
		ActualObject = "Guerison"
func _on_Rappel_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Rappel"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Rappel"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Ranime un Pokémon K.O. et restaure 50% de ses PV")
		ActualObject = "Rappel"
func _on_RappelMax_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/RappelMax"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/RappelMax"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Ranime un Pokémon K.O. et restaure tous ses PV")
		ActualObject = "RappelMax"
func _on_Antidote_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Antidote"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Antidote"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne l'empoisonnement de votre pokemon")
		ActualObject = "Antidote"
func _on_AntiPara_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/AntiPara"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/AntiPara"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne la paralysie de votre pokemon")
		ActualObject = "AntiPara"
func _on_AntiBrule_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/AntiBrule"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/AntiBrule"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne la brulure de votre pokemon")
		ActualObject = "AntiBrule"
func _on_Reveil_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Reveil"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Reveil"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne le sommeil de votre pokemon")
		ActualObject = "Reveil"
func _on_TotalSoin_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/TotalSoin"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/TotalSoin"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne tous les problèmes de statut")
		ActualObject = "TotalSoin"
func _on_Elixir_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Elixir/Elixir"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Elixir/Elixir"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 10 PP d'une capacité d'un Pokemon")
		ActualObject = "Elixir"
func _on_MaxElixir_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxElixir/MaxElixir"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxElixir/MaxElixir"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure tous les PP d'une capacité d'un Pokémon")
		ActualObject = "MaxElixir"
func _on_Huile_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Huile/Huile"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Huile/Huile"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 10 PP de chaque capacité d'un Pokémon")
		ActualObject = "Huile"
func _on_MaxHuile_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxHuile/MaxHuile"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxHuile/MaxHuile"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure tous les PP de chaque capacité d'un Pokémon")
		ActualObject = "MaxHuile"
func _on_Eau_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Eau"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Eau"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 50 PV d'un Pokémon")
		ActualObject = "Eau"
func _on_Soda_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Soda"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Soda"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 60 PV d'un Pokémon")
		ActualObject = "Soda"
func _on_Limonade_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Limonade"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Limonade"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 80 PV d'un Pokémon")
		ActualObject = "Limonade"
func _on_Lait_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Lait"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Lait"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 100 PV d'un Pokémon")
		ActualObject = "Lait"

#Pokeballs
func _on_Pokeball_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Pokeball"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Pokeball"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Permet de capturer des Pokémon")
		ActualObject = "Pokeball"
func _on_SuperBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/SuperBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/SuperBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Version améliorée de la Pokeball")
		ActualObject = "SuperBall"
func _on_HyperBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/HyperBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/HyperBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Version améliorée de la SuperBall")
		ActualObject = "HyperBall"
func _on_ChronoBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/ChronoBall/ChronoBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/ChronoBall/ChronoBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Plus le combat est long, plus la Ball est efficace")
		ActualObject = "ChronoBall"
func _on_FiletBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/FiletBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/FiletBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Plus efficace sur les Pokémon Eau et Insecte")
		ActualObject = "FiletBall"
func _on_FaibloBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/FaibloBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/FaibloBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Plus le Pokémon est bas niveau, plus la Ball est efficace")
		ActualObject = "FaibloBall"
func _on_MasterBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/MasterBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/MasterBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Permet de capturer à coup sur un Pokemon")
		ActualObject = "MasterBall"

#Objects
func _on_CordeDeSortie_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/ObjectBox/ScrollContainer/VBoxContainer/Objet1/CordeDeSortie/CordeDeSortie"
		if (get_node(ActualTextureSelection).modulate == Color.black) :
			pass
		else :
			Same("Permet de revenir à l'entrée d'une grotte ou d'un lieu")
			ActualObject = "CordeDeSortie"
func _on_Repousse_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/ObjectBox/ScrollContainer/VBoxContainer/Objet1/Repousse/Repousse"
		if (get_node(ActualTextureSelection).modulate == Color.black) :
			pass
		else :
			Same("Empeche la rencontre de Pokemon Ennemi pendant quelques instants")
			ActualObject = "Repousse"
func _on_SuperRepousse_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/ObjectBox/ScrollContainer/VBoxContainer/Objet1/SuperRepousse/SuperRepousse"
		if (get_node(ActualTextureSelection).modulate == Color.black) :
			pass
		else :
			Same("Empeche la rencontre de Pokemon Ennemi pendant un plus long instant")
			ActualObject = "SuperRepousse"

#RareObjects
func _on_Carte_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/Carte/Carte"
		Same("Une carte très pratique indiquant votre position actuelle")
func _on_ChaussuresDeCourse_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/ChaussuresDeCourse/ChaussuresDeCourse"
		ActualObject = "ChaussuresDeCourse"
		Same("Permet de courir plus rapidement")
func _on_BoiteCT_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/BoiteCT/BoiteCT"
		Same("Une boîte pour ranger les CT et CS")
		ActualObject = "BoiteCT"
func _on_OrbeMysterieuse_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/OrbeMysterieuse/OrbeMysterieuse"
		Same("Une etrange orbe verte que Chen vous a donné lorsque vous avez commencé votre aventure")
func _on_Velo_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares2/Velo/Velo"
		Same("Un formidable velo vous permettant d'aller plus vite qu'à pied")
func _on_ColisDeChen_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares2/Colis/Colis"
		Same("Un paquet à livrer au Prof")

#OTHERS FUNCTIONS
#LOAD FUNCTIONS
func loadValues() :
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberSuperPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberHyperPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberMaxPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberGuerison)
	$MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberRappel)
	$MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberRappelMax)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberAntidote)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberAntiPara)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberAntiBrule)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberReveil)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberTotalSoin)
	$MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Elixir/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberElixir)
	$MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxElixir/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberMaxElixir)
	$MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Huile/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberHuile)
	$MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxHuile/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberMaxHuile)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberEau)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberSoda)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberLimonade)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberLait)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberPokeball)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberSuperBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberHyperBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/ChronoBall/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberChronoBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberFiletBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberFaibloBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberMasterBall)
	$ObjectBox/ScrollContainer/VBoxContainer/Objet1/CordeDeSortie/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberCordeDeSortie)
	$ObjectBox/ScrollContainer/VBoxContainer/Objet1/Repousse/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberRepousse)
	$ObjectBox/ScrollContainer/VBoxContainer/Objet1/SuperRepousse/Number.text = "X" + str(PG.AllObject["NumberObject"].NumberSuperRepousse)
	for x in PG.AllObject["NumberObject"] :
		if PG.AllObject["NumberObject"][x] == 0 :
			SetAndGetModulate(str(x)).modulate = Color.black
#CHECK COLORS FUCNTIONS
func SetAndGetModulate(x) :
	var ThePath
	match x :
		"NumberPotion" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Potion
		"NumberSuperPotion" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/SuperPotion
		"NumberHyperPotion" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/HyperPotion
		"NumberMaxPotion" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/MaxPotion
		"NumberGuerison" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Guerison
		"NumberRappel" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Rappel
		"NumberRappelMax" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/RappelMax
		"NumberAntidote" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Antidote
		"NumberAntiPara" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/AntiPara
		"NumberAntiBrule" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/AntiBrule
		"NumberReveil" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Reveil
		"NumberTotalSoin" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/TotalSoin
		"NumberElixir" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Elixir/Elixir
		"NumberMaxElixir" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxElixir/MaxElixir
		"NumberHuile" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/Huile/Huile
		"NumberMaxHuile" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/ElixirsHuiles/MaxHuile/MaxHuile
		"NumberEau" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Eau
		"NumberSoda" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Soda
		"NumberLimonade" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Limonade
		"NumberLait" :
			ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Lait
		"NumberPokeball" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Pokeball
		"NumberSuperBall" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/SuperBall
		"NumberHyperBall" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/HyperBall
		"NumberChronoBall" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/ChronoBall/ChronoBall
		"NumberFiletBall" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/FiletBall
		"NumberFaibloBall" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/FaibloBall
		"NumberMasterBall" :
			ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/MasterBall
		"NumberCordeDeSortie" :
			ThePath = $ObjectBox/ScrollContainer/VBoxContainer/Objet1/CordeDeSortie/CordeDeSortie
		"NumberRepousse" :
			ThePath = $ObjectBox/ScrollContainer/VBoxContainer/Objet1/Repousse/Repousse
		"NumberSuperRepousse" :
			ThePath = $ObjectBox/ScrollContainer/VBoxContainer/Objet1/SuperRepousse/SuperRepousse
	return ThePath
#GET DICTIONNARY OBJECT
func GetDictionnaryValue(TheObject : String) :
	match TheObject :
		"Potion" :
			return PG.AllObject["NumberObject"].NumberPotion
		"SuperPotion" :
			return PG.AllObject["NumberObject"].NumberSuperPotion
		"HyperPotion" :
			return PG.AllObject["NumberObject"].NumberHyperPotion
		"MaxPotion" :
			return PG.AllObject["NumberObject"].NumberMaxPotion
		"Guerison" :
			return PG.AllObject["NumberObject"].NumberGuerison
		"Rappel" :
			return PG.AllObject["NumberObject"].NumberRappel
		"RappelMax" :
			return PG.AllObject["NumberObject"].NumberRappelMax
		"Antidote" :
			return PG.AllObject["NumberObject"].NumberAntidote
		"AntiPara" :
			return PG.AllObject["NumberObject"].NumberAntiPara
		"AntiBrule" :
			return PG.AllObject["NumberObject"].NumberAntiBrule
		"Reveil" :
			return PG.AllObject["NumberObject"].NumberReveil
		"TotalSoin" :
			return PG.AllObject["NumberObject"].NumberTotalSoin
		"Elixir" :
			return PG.AllObject["NumberObject"].NumberElixir
		"MaxElixir" :
			return PG.AllObject["NumberObject"].NumberMaxElixir
		"Huile" :
			return PG.AllObject["NumberObject"].NumberHuile
		"MaxHuile" :
			return PG.AllObject["NumberObject"].NumberMaxHuile
		"Eau" :
			return PG.AllObject["NumberObject"].NumberEau
		"Soda" :
			return PG.AllObject["NumberObject"].NumberSoda
		"Limonade" :
			return PG.AllObject["NumberObject"].NumberLimonade
		"Lait" :
			return PG.AllObject["NumberObject"].NumberLait
		"Pokeball" :
			return PG.AllObject["NumberObject"].NumberPokeball
		"SuperBall" :
			return PG.AllObject["NumberObject"].NumberSuperBall
		"HyperBall" :
			return PG.AllObject["NumberObject"].NumberHyperBall
		"ChronoBall" :
			return PG.AllObject["NumberObject"].NumberChronoBall
		"FiletBall" :
			return PG.AllObject["NumberObject"].NumberFiletBall
		"FaibloBall" :
			return PG.AllObject["NumberObject"].NumberFaibloBall
		"MasterBall" :
			return PG.AllObject["NumberObject"].NumberMasterBall
		"CordeDeSortie" :
			return PG.AllObject["NumberObject"].NumberCordeDeSortie
		"Repousse" :
			return PG.AllObject["NumberObject"].NumberRepousse
		"SuperRepousse" :
			return PG.AllObject["NumberObject"].NumberSuperRepousse
#REPEAT ACTIONS
func quit_scene() :
	PG.CantdisplayMenu = false
	$ChoicePopup.hide()
	$JeterPopup.hide()
	self.visible = false
	get_tree().paused = false
	$AnimationPlayer.play("Exit")
	yield($AnimationPlayer,"animation_finished")
func Same(Text) :
	NodeTextureSelection = get_node(ActualTextureSelection)
	$ChoicePopup.popup()
	$InformationText.text = Text
	$AnimationPlayer.play("IdleSelectChoice")
func RepeatUse1() :
	quit_scene()
	MenuPokemonScene.UsingObject = true
	MenuPokemonScene.visible = true
	MenuPokemonScene.TheObject = ActualObject
func CatchAPokemonInFight(PokeballBonus,PokeballName) :
	quit_scene()
	emit_signal("catchapokemon",PokeballBonus,PokeballName)

#SIGNAL FUNCTIONS
func _on_MenuPokemon_ChangeNumberObject(Name):
	self.visible = true
	match Name:
		"Potion" :
			PG.AllObject["NumberObject"].NumberPotion -= 1
		"SuperPotion" :
			PG.AllObject["NumberObject"].NumberSuperPotion -= 1
		"HyperPotion" :
			PG.AllObject["NumberObject"].NumberHyperPotion-= 1
		"MaxPotion" :
			PG.AllObject["NumberObject"].NumberMaxPotion-= 1
		"Guerison" :
			PG.AllObject["NumberObject"].NumberGuerison-= 1
		"Rappel" :
			PG.AllObject["NumberObject"].NumberRappel-= 1
		"RappelMax" :
			PG.AllObject["NumberObject"].NumberRappelMax-= 1
		"Antidote" :
			PG.AllObject["NumberObject"].NumberAntidote-= 1
		"AntiPara" :
			PG.AllObject["NumberObject"].NumberAntiPara-= 1
		"AntiBrule" :
			PG.AllObject["NumberObject"].NumberAntiBrule-= 1
		"Reveil" :
			PG.AllObject["NumberObject"].NumberReveil-= 1
		"TotalSoin" :
			PG.AllObject["NumberObject"].NumberTotalSoin-= 1
		"Elixir" :
			PG.AllObject["NumberObject"].NumberElixir-= 1
		"MaxElixir" :
			PG.AllObject["NumberObject"].NumberMaxElixir-= 1
		"Huile" :
			PG.AllObject["NumberObject"].NumberHuile-= 1
		"MaxHuile" :
			PG.AllObject["NumberObject"].NumberMaxHuile-= 1
		"Eau" :
			PG.AllObject["NumberObject"].NumberEau-= 1
		"Soda" :
			PG.AllObject["NumberObject"].NumberSoda-= 1
		"Limonade" :
			PG.AllObject["NumberObject"].NumberLimonade-= 1
		"Lait" :
			PG.AllObject["NumberObject"].NumberLait-= 1
		"Pokeball" :
			PG.AllObject["NumberObject"].NumberPokeball-= 1
		"SuperBall" :
			PG.AllObject["NumberObject"].NumberSuperBall-= 1
		"HyperBall" :
			PG.AllObject["NumberObject"].NumberHyperBall-= 1
		"ChronoBall" :
			PG.AllObject["NumberObject"].NumberChronoBall-= 1
		"FiletBall" :
			PG.AllObject["NumberObject"].NumberFiletBall-= 1
		"FaibloBall" :
			PG.AllObject["NumberObject"].NumberFaibloBall-= 1
		"MasterBall" :
			PG.AllObject["NumberObject"].NumberMasterBall-= 1
		"CordeDeSortie" :
			PG.AllObject["NumberObject"].NumberCordeDeSortie-= 1
		"Repousse" :
			PG.AllObject["NumberObject"].NumberRepousse-= 1
		"SuperRepousse" :
			PG.AllObject["NumberObject"].NumberSuperRepousse-= 1
