#     LINEAR PNJ : EXAMPLE

extends KinematicBody2D

signal loadPlayerParametre

export (float) var vitesse
export (String) var TXT
export (String) var TXTIntro
export (String) var EnnemiName
export (Texture) var TheTexture
export (Texture) var TheInFightTexture

export (Dictionary) var POKEMON1 = {
	Name = "Racaillou",
	Lvl = 10,
	Hp = 31,
	MaxHp = 25,
	Puissance = 80,
	Defense = 100,
	AttaqueSpecial = 30,
	DefenseSpecial = 30,
	Vitesse = 20,
	Experience = 0,
	LvlNeededToEvolve = 16,
	ExperienceNeededToLvlUp = 30,
	Statut = "",
	Type1 = "Roche",
	Type2 = "-",
	Attaque1 = "Boul'Armure",
	Attaque2 = "Charge",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20}
export (Dictionary) var POKEMON2 = {
	Name = "Sabelette",
	Lvl = 11,
	Hp = 50,
	MaxHp = 35,
	Puissance = 75,
	Defense = 85,
	AttaqueSpecial = 20,
	DefenseSpecial = 30,
	Vitesse = 40,
	Experience = 0,
	LvlNeededToEvolve = 16,
	ExperienceNeededToLvlUp = 30,
	Statut = "",
	Type1 = "Sol",
	Type2 = "-",
	Attaque1 = "Griffe",
	Attaque2 = "Boul'Armure",
	Attaque3 = "Jet De Sable",
	Attaque4 = "-",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20}
export (Dictionary) var POKEMON3 
export (Dictionary) var POKEMON4
export (Dictionary) var POKEMON5
export (Dictionary) var POKEMON6

onready var player = get_node(PG.ActualScene + "/Player")
onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var animationFight = get_node("/root/Map/GUITotal").get_node("Fight")

var Velocity = Vector2()
var IsFightLaunch = false

func _ready():
	if TheTexture != null : $Sprite.texture = TheTexture

func _physics_process(_delta):
	if (IsFightLaunch) :
		PG.UnUsed = move_and_collide(Velocity)

func _on_LinearPNJ_tree_entered():
	Velocity.y = vitesse
	IsFightLaunch = false
	$Exclamation.visible = false
	$Exclamation.stop()

func LaunchFight() :
#	Animation
	$Exclamation.visible = true
	$Exclamation.play("Rouge")
#	Use for Detecting the player
	yield(get_tree().create_timer(1),"timeout")
	$Exclamation.visible = false
	$Exclamation.stop()
	IsFightLaunch = true

func _on_Area2D_body_entered(body):
	if (IsFightLaunch and body == player) :
		loadParameters()
		Velocity.y = 0
		UISpeackScene.display_a_txt(TXT)
		while (!UISpeack.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
			if (UISpeack.PassTxt) :
				IsFightLaunch = false
				UIFight.TxtIntro = TXTIntro
				UIFight.TypeOfFight = "FightDresseur"
				animationFight.play("LaunchingFight")
				PG.ActualScene = "/root/FightScene"
				yield(animationFight,"animation_finished")
				PG.UnUsed = get_tree().change_scene("res://Fight/FightScene.tscn")

func _on_Area2D2_body_entered(body):
	if (body == player) :
		LaunchFight()

func loadParameters() :
#	Texture and Graphic
	EG.TextureFight = TheInFightTexture
	UIFight.CercleFight = load("res://img Pokemon/img Fight/Graphique/CercleFightWhite.png")
	UIFight.BGCOLOR = Color(1, 1, 1)
#	Pokemon
	EG.Pokemon1 = POKEMON1
	EG.Pokemon2 = POKEMON2
	EG.Pokemon3 = POKEMON3
	EG.Pokemon4 = POKEMON4
	EG.Pokemon5 = POKEMON5
	EG.Pokemon6 = POKEMON6
#	Information
	EG.EnnemiName = EnnemiName
