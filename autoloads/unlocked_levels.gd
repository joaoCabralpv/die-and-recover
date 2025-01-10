extends Node

var _UnlockedLevels: Array[String] = ["1"]
var AllUnlocked = true #This variable shouldn't be accessed directly outside of this script

func unlock_level(level:String):
	_UnlockedLevels.push_back(level)
