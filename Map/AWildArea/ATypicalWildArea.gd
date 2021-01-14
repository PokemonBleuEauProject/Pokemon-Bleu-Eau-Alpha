extends Area2D

onready var Player = get_node("/root/Map/Player")
onready var animationFight = get_node("/root/Map/CanvasLayer/Fight")

export var ListPokemon = [{Name = "Chenipan",x = 10},{Name = "Roucool",x=10},{Name = "Chrysacier",x=10}]

var IsPlayerIn = false

func _ready():
	IsPlayerIn = false

func _input(event):
	if IsPlayerIn :
		if (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")) :
			VerifyPokemon()

func _on_Area2D_body_entered(body):
	if (body == Player) :
		IsPlayerIn = true

func _on_Area2D_body_exited(body):
	IsPlayerIn = false

func VerifyPokemon() :
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var Random = ARandom.randi_range(0,2)
	var RandomLaunch = ARandom.randf_range(0,1)
	var PokemonRNG = (ListPokemon[Random].x) * 0.006
	if PokemonRNG >= RandomLaunch :
		UIFight.IsFightLaunch = true
		loadParameters()
		animationFight.play("LaunchingFight")
		yield(get_tree().create_timer(2.3),"timeout")
		get_tree().change_scene("res://Fight/FightScene.tscn")

func loadParameters() :
#	Pokemon
	EG.Pokemon1 = {Name = "Salameche", Nickname = "Starter", Lvl = 4, Hp = 19, MaxHp = 19, Exp = 0, Attaque1 = "Griffe", Attaque2 = "Rugissement"}
#	Information
	EG.EnnemiName = ""
	UIFight.TypeOfFight = "Savage"
	UIFight.TxtIntro = "Un pokemon sauvage apparait !!"
