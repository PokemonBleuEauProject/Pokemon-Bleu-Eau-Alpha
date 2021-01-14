extends AnimationPlayer

#Change Pokemon
func _on_UIFight_ChangePokemon():
	self.play("ChangePokemon-Normal")
func _on_UIAction_ChangePokemonReturn():
	self.play("ChangePokemon-Return")
func _on_UIFight_EnterTreeChangePokemon():
	self.play("ChangePokemon-Player-EnterTree")
func _on_UIFight_ChangeEnnemiPokemon():
	self.play("ChangePokemon-Ennemi-Normal")
func _on_UIAction_ChangePokemon():
	self.play("ChangePokemon-Normal")
#EnterTree Animations
func _on_UIFight_EnterTreeAnimation():
	self.play("LaunchFight-Dresseur-EnterTree")
func _on_UIFight_EnterTreeAnimation2():
	self.play("LaunchFight-Savage-EnterTree")
