extends Popup

onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
onready var PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
onready var UiFight = get_node("/root/FightScene/UIFight")
onready var MenuPokemon = get_node("/root/FightScene/MenuPokemon")
onready var Bag = get_node("/root/FightScene/Bag")
onready var UiFight_Text = get_node("/root/FightScene/UIFight/Text")
onready var UiFight_ShowText = get_node("/root/FightScene/UIFight/ShowText")
onready var UiAction = get_node("/root/FightScene/UIAction")
onready var AllAnimation = get_node("/root/FightScene/AnimationPlayer")
onready var AttaqueAnimation = get_node("/root/FightScene/AttaqueAnimation")
onready var UiPokemonBox = get_node("/root/FightScene/UIPokemonBox")
onready var UiPokemonBoxE = get_node("/root/FightScene/UIPokemonBoxEnnemi")
onready var UiAttaque = get_node("/root/FightScene/UIAttaque")

var actual_arrow = 0
var Cantmove = false
var NeedDisplayUIPokemonBox

var TempPokemon

signal DisplayUIAttaque
signal DisplayUIPokemonBox
signal ChangePokemonReturn
signal ChangePokemon

func _input(_event):
	if (!self.visible) or Cantmove :  UIFight.CanAnimationBeSet = true
	elif UIFight.CanAnimationBeSet : 
		UIFight.CanAnimationBeSet = false
		get_node("/root/FightScene/AnimationPlayer").play("IDLEAnimation")
	elif (Input.is_action_pressed("ui_accept")) :
		match actual_arrow :
			0 :
#				UIATTAQUE
				emit_signal("DisplayUIAttaque")
				self.hide()
			1 :
#				BAG
				Bag.UseObjectInFight = true
				Cantmove = true
				get_node("/root/FightScene/AnimationPlayer").play("GoBag")
			2 :
				#MENU POKEMON
				get_node("/root/FightScene/AnimationPlayer").play("GoMenuPokemon")
				MenuPokemon.ChangePokemonInFight = true
				Cantmove = true
				MenuPokemon.PokemonHasChanged = null
				while(MenuPokemon.PokemonHasChanged == null) : yield(get_tree().create_timer(0.1),"timeout")
				if MenuPokemon.PokemonHasChanged :
					yield(get_tree().create_timer(1.5),"timeout")
					if Attaque.GetFirstAttacker(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse,"") :
						UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " revient !")
						yield(get_tree().create_timer(0.6),"timeout")
						emit_signal("ChangePokemonReturn")
						yield(get_tree().create_timer(1.5),"timeout")
						match MenuPokemon.PokemonToChanged :
							"2" :
								PokemonPlayer.ChangePokemon("2")
							"3" :
								PokemonPlayer.ChangePokemon("3")
							"4" :
								PokemonPlayer.ChangePokemon("4")
							"5" :
								PokemonPlayer.ChangePokemon("5")
							"6" :
								PokemonPlayer.ChangePokemon("6")
						UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
						emit_signal("ChangePokemon")
						get_node("/root/FightScene/UIPokemonBox").load_values(PokemonPlayer.PokemonPlayer.Name,PokemonPlayer.PokemonPlayer.Lvl,PokemonPlayer.PokemonPlayer.Hp,PokemonPlayer.PokemonPlayer.MaxHp,PokemonPlayer.PokemonPlayer.Experience,PokemonPlayer.PokemonPlayer.ExperienceNeededToLvlUp)
						yield(get_tree().create_timer(2),"timeout")
						yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
						Cantmove = false
						UiFight.changeText("Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?")
					else : 
						yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
						UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " revient !")
						yield(get_tree().create_timer(0.6),"timeout")
						emit_signal("ChangePokemonReturn")
						yield(get_tree().create_timer(1.5),"timeout")
						match MenuPokemon.PokemonToChanged :
							"2" :
								PokemonPlayer.ChangePokemon("2")
							"3" :
								PokemonPlayer.ChangePokemon("3")
							"4" :
								PokemonPlayer.ChangePokemon("4")
							"5" :
								PokemonPlayer.ChangePokemon("5")
							"6" :
								PokemonPlayer.ChangePokemon("6")
						UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
						emit_signal("ChangePokemon")
						get_node("/root/FightScene/UIPokemonBox").load_values(PokemonPlayer.PokemonPlayer.Name,PokemonPlayer.PokemonPlayer.Lvl,PokemonPlayer.PokemonPlayer.Hp,PokemonPlayer.PokemonPlayer.MaxHp,PokemonPlayer.PokemonPlayer.Experience,PokemonPlayer.PokemonPlayer.ExperienceNeededToLvlUp)
						Cantmove = false
				else : Cantmove = false
			3 :
#				FUITE
				Cantmove = true
				if (UIFight.TypeOfFight == "FightDresseur") :
					UiFight.changeText("Vous ne pouvez pas fuire ce combat !")
					Cantmove = true
					self.hide()
					yield(UiFight_ShowText,"animation_finished")
					yield(get_tree().create_timer(0.3),"timeout")
					UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
					Cantmove = false
					self.popup()
				elif(Attaque.fuite(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse)) :
					UiFight.changeText("Vous prennez la fuite !")
					yield(UiFight_ShowText,"animation_finished")
					get_node("/root/FightScene/AnimationPlayer").play("EndOfFight")
					yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
					Cantmove = false
					PG.UnUsed = get_tree().change_scene("res://Map/map.tscn")
				else :
					UiFight.changeText("Vous ne parvenez pas à prendre la fuite !")
					Cantmove = true
					self.hide()
					yield(UiFight_ShowText,"animation_finished")
					yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
					Cantmove = false
					self.popup()
	elif ((Input.is_action_just_pressed("ui_down")) or (Input.is_action_just_pressed("ui_up"))) :
		match actual_arrow :
			0 :
				actual_arrow = 2
				$AttaqueArrow.visible = false
				$PokemonArrow.visible = true
			1 :
				actual_arrow = 3
				$SacArrow.visible = false
				$FuiteArrow.visible = true
			2 :
				actual_arrow = 0
				$AttaqueArrow.visible = true
				$PokemonArrow.visible = false
			3 :
				actual_arrow = 1
				$SacArrow.visible = true
				$FuiteArrow.visible = false
	elif ((Input.is_action_just_pressed("ui_left")) or (Input.is_action_just_pressed("ui_right"))) :
		match actual_arrow :
			0 :
				actual_arrow = 1
				$AttaqueArrow.visible = false
				$SacArrow.visible = true
			1 :
				actual_arrow = 0
				$SacArrow.visible = false
				$AttaqueArrow.visible = true
			2 :
				actual_arrow = 3
				$FuiteArrow.visible = true
				$PokemonArrow.visible = false
			3 :
				actual_arrow = 2
				$PokemonArrow.visible = true
				$FuiteArrow.visible = false

func _on_Bag_catchapokemon(PokeballBonus,PokeballName):
	self.popup()
	UiFight.popup()
	UiPokemonBox.popup()
	UiPokemonBoxE.popup()
	UiFight.changeText("Vous utilisez une " + PokeballName)
	yield(UiFight_ShowText,"animation_finished")
	AllAnimation.play("CatchPokemon-Normal")
	yield(AllAnimation,"animation_finished")
	Attaque.CatchAPokemon(PokemonEnnemi.PokemonEnnemi.MaxHp,PokemonEnnemi.PokemonEnnemi.Hp,PokemonEnnemi.PokemonEnnemi.CatchRate,PokemonEnnemi.PokemonEnnemi.Statut,PokeballBonus)
	for x in range(0,3) :
		if UIAction.CatchShiver[x] :
			AllAnimation.play("CatchPokemon-Shiver")
			yield(get_tree().create_timer(2),"timeout")
		else :
			AllAnimation.play("CatchPokemon-Fail")
			yield(AllAnimation,"animation_finished")
			break
	var Bool = true
	for x in range(0,3) :
		if UIAction.CatchShiver[x] :
			pass
		else :
			Bool = false
	if Bool : UIAction.ThePokemonIsCatch = true
	else : UIAction.ThePokemonIsCatch = false
	if UIAction.ThePokemonIsCatch :
		AllAnimation.play("CatchPokemon-Success")
		UiFight.changeText("Et hop ! " + PokemonEnnemi.PokemonEnnemi.Name + " sauvage est attrapé !")
		yield(UiFight_ShowText,"animation_finished")
		yield(get_tree().create_timer(1),"timeout")
		ChangingPokemonAfterCatch(PG.CheckDictionnaryPokemonFree())
		UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " fait maintenant partie de votre équipe !")
		yield(UiFight_ShowText,"animation_finished")
		UiFight.changeText(Pokedex.CheckNewPokemonDiscover(PokemonEnnemi.PokemonEnnemi.Name))
		yield(UiFight_ShowText,"animation_finished")
		get_node("/root/FightScene/AnimationPlayer").play("EndOfFight")
		yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
		PG.UnUsed = get_tree().change_scene("res://Map/map.tscn")
	else :
		UiAttaque.hide()
		var AttaqueEnnemi = PokemonEnnemi.EnnemiLaunchAttack()
		yield(get_tree().create_timer(0.75),"timeout")
		UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " utilise " + AttaqueEnnemi + " !")
		yield(UiFight_ShowText,"animation_finished")
		if Attaque.CheckSuccess("Ennemi",AttaqueEnnemi) :
			AttaqueAnimation.play(AttaqueEnnemi+" E")
			UiAttaque.emit_signal("AboutLoadingValues")
			Attaque.CheckAttack(AttaqueEnnemi,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Ennemi")
			yield(get_tree().create_timer(1),"timeout")
			Attaque.EventText("Ennemi")
			if (Attaque.EvenText != "") :
				UiFight.changeText(Attaque.EvenText)
				yield(UiFight_ShowText,"animation_finished")
			if (Attaque.SpecialText != "") :
				UiFight.changeText(Attaque.SpecialText)
				yield(UiFight_ShowText,"animation_finished")
				Attaque.SpecialText = ""
			UiAttaque.emit_signal("ChangeStatut",Attaque.GetAndSetStatut(PokemonPlayer.PokemonPlayer))
		else :
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " rate son attaque !")
			yield(UiFight_ShowText,"animation_finished")
		UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
		UiAttaque.emit_signal("LoadValues")
		if Attaque.IsFlyingE :
			UiAttaque.emit_signal("AboutLoadingValues")
			Attaque.UseVolE(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("UseVolE")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " utilise Vol !")
			yield(UiFight_ShowText,"animation_finished")
			UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			UiAttaque.emit_signal("LoadValues")
		if Attaque.VampiDraine :
			UiAttaque.emit_signal("AboutLoadingValues")
			Attaque.DrainVampigraine(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("VampigraineDrain")
			UiFight.changeText("Vampigraine drain l'énergie de " + PokemonEnnemi.PokemonEnnemi.Name + " ennemi !")
			yield(UiFight_ShowText,"animation_finished")
			UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			UiAttaque.emit_signal("LoadValues")
		if Attaque.VampiDraineE :
			UiAttaque.emit_signal("AboutLoadingValues")
			Attaque.DrainVampigraineE(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("VampigraineDrain E")
			UiFight.changeText("Vampigraine drain l'énergie de " + PokemonPlayer.PokemonPlayer.Name)
			yield(UiFight_ShowText,"animation_finished")
			UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			UiAttaque.emit_signal("LoadValues")
		if Attaque.CheckPokemonStatut(PokemonEnnemi.PokemonEnnemi) :
			UiAttaque.emit_signal("AboutLoadingValues")
			UiFight.changeText(Attaque.StatutSentence)
			yield(UiFight_ShowText,"animation_finished")
			AttaqueAnimation.play(PokemonEnnemi.PokemonEnnemi.Statut + " E")
			yield(get_tree().create_timer(1),"timeout")
			UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			UiAttaque.emit_signal("LoadValues")
		if Attaque.CheckPokemonStatut(PokemonPlayer.PokemonPlayer) :
			UiAttaque.emit_signal("AboutLoadingValues")
			UiFight.changeText(Attaque.StatutSentence)
			yield(UiFight_ShowText,"animation_finished")
			AttaqueAnimation.play(PokemonEnnemi.PokemonEnnemi.Statut)
			yield(get_tree().create_timer(1),"timeout")
			UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			UiAttaque.emit_signal("LoadValues")
		UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
		UiAttaque.hide()
		UiAction.popup()
		UiAttaque.actual_arrow = null
		Cantmove = false

#OTHERS FUNCTIONS
func ChangingPokemonAfterCatch(Something) :
	PokemonEnnemi.saveParameters(EG.Pokemon1)
	match Something :
		1 :
			PG.Pokemon1 = EG.Pokemon1
		2 :
			PG.Pokemon2 = EG.Pokemon1
		3 :
			PG.Pokemon3 = EG.Pokemon1
		4 :
			PG.Pokemon4 = EG.Pokemon1
		5 :
			PG.Pokemon5 = EG.Pokemon1
		6 :
			PG.Pokemon1 = EG.Pokemon1
