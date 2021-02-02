extends Node

var save_path = "user://save.txt"

var AllData = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime,
	"EG.RivaleName" : EG.RivalName,
	"PG.Badge" : PG.Badge,
	"PG.Argent" : PG.Argent,
	"PG.ActualScene" : PG.ActualScene,
	"PG.Last_position" : PG.Last_position,
	"PG.NodePositionPath" : PG.NodePositionPath}
var ListVariable = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime,
	"EG.RivaleName" : EG.RivalName,
	"PG.Badge" : PG.Badge,
	"PG.Argent" : PG.Argent,
	"PG.ActualScene" : PG.ActualScene,
	"PG.Last_position" : PG.Last_position,
	"PG.NodePositionPath" : PG.NodePositionPath}
var DefaulValue = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : null,
	"PG.Pokemon3" : null,
	"PG.Pokemon4" : null,
	"PG.Pokemon5" : null,
	"PG.Pokemon6" : null,
	"PG.GameTime" : {Minutes = 0,Hours = 0,Days = 0},
	"EG.RivaleName" : "TheRival",
	"PG.Badge" : PG.Badge,
	"PG.Argent" : 0,
	"PG.ActualScene" : null,
	"PG.Last_position" : null,
	"PG.NodePositionPath" : null
	}

func saveActualData() : 
	ListVariable = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime,
	"EG.RivaleName" : EG.RivalName,
	"PG.Badge" : PG.Badge,
	"PG.Argent" : PG.Argent,
	"PG.ActualScene" : PG.ActualScene,
	"PG.Last_position" : PG.Last_position,
	"PG.NodePositionPath" : PG.NodePositionPath
	}
func loadActualData(TheData) :
	match TheData :
		"PG.PlayerName" : PG.PlayerName = AllData[TheData]
		"PG.Pokemon1" : PG.Pokemon1 = AllData[TheData]
		"PG.Pokemon2" : PG.Pokemon2 = AllData[TheData]
		"PG.Pokemon3" : PG.Pokemon3 = AllData[TheData]
		"PG.Pokemon4" : PG.Pokemon4 = AllData[TheData]
		"PG.Pokemon5" : PG.Pokemon5 = AllData[TheData]
		"PG.Pokemon6" : PG.Pokemon6 = AllData[TheData]
		"PG.GameTime" : PG.GameTime = AllData[TheData]
		"EG.RivaleName" : EG.RivalName = AllData[TheData]
		"PG.Badge" : PG.Badge = AllData[TheData]
		"PG.Argent" : PG.Argent = AllData[TheData]
		"PG.ActualScene" : PG.ActualScene = AllData[TheData]
		"PG.Last_position" : PG.Last_position = AllData[TheData]
		"PG.NodePositionPath" : PG.NodePositionPath = AllData[TheData]

func saveData() :
	saveActualData()
	AllData = ListVariable
func loadData() :
	loadAllDataFromFile()
	for x in AllData :
		print(x)
		loadActualData(x)
func loadAllDataFromFile() :
	var file = File.new()
	file.open("user://save.txt", File.READ)
	AllData = file.get_var()
	file.close()
func saveGame() :
	var save = File.new()
	var error = save.open(save_path,File.WRITE)
	if error == OK :
		saveData()
		print("The Save data name is" + Save.AllData["PG.PlayerName"])
		save.store_var(AllData)
		save.close()
func loadGame() :
	var save = File.new()
	if save.file_exists(save_path) :
		var error = save.open(save_path,File.READ)
		if error == OK :
			loadData()
			save.close()

func deleteSave() :
	AllData = DefaulValue
	loadGame()
