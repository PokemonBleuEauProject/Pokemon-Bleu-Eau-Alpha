extends Popup

var ActualLife

func ready() :
	ActualLife = PokemonPlayer.PokemonPlayer.Hp
	AnimationLoadLife.track_set_key_value(0,0,ActualLife)
	AnimationLoadLife.track_set_key_value(0,1,ActualLife)

onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")

onready var Name = get_node("/root/FightScene/UIPokemonBox/Name")
onready var Lvl = get_node("/root/FightScene/UIPokemonBox/Lvl")
onready var LifeScript = get_node("/root/FightScene/UIPokemonBox/LifeScript")
onready var LifeProgress = get_node("/root/FightScene/UIPokemonBox/LifeProgress")
onready var ExpProgress = get_node("/root/FightScene/UIPokemonBox/ExpProgress")
onready var AnimationLoadLife = $AnimationPlayer.get_animation("LoadLife")

func load_values(NamePlayer,LvlPlayer,LifePlayer,MaxLifePlayer,Experience,ExperienceNeededToLvlUp) :
	Name.text = NamePlayer
	Lvl.text = "N." + str(LvlPlayer)
	LifeScript.text = str(LifePlayer) + "/" + str(MaxLifePlayer)
	LifeProgress.max_value = MaxLifePlayer
	LifeProgress.value = LifePlayer
	ExpProgress.value = Experience
	ExpProgress.max_value = ExperienceNeededToLvlUp
	AnimationLoadLife.track_set_key_value(0,0,ActualLife)
	AnimationLoadLife.track_set_key_value(0,1,LifePlayer)
	if (ActualLife == LifePlayer) : pass
	else :  $AnimationPlayer.play("LoadLife")

func _on_UIAttaque_ChangeStatut(TheStatut):
	if TheStatut == "-" : pass
	else : $AnimationPlayer.play(TheStatut)

func _on_UIAttaque_AboutLoadingValues():
	ActualLife = PokemonPlayer.PokemonPlayer.Hp
