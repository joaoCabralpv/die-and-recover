extends Recovery

signal recover(player:Character)
@onready var level:Level = $".."

func _process(_delta):
	for player in level.DeadPlayerArray:
		if player.name.to_lower() == "firey":
			recover.emit(player)
			player.position = position
