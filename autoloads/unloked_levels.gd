extends Node

var _UnlokedLevels: Array[String] = ["1"]
var AllUnlocked = false

func unlock_level(level:String):
	_UnlokedLevels.push_back(level)
