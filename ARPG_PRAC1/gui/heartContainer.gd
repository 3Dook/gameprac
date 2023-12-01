extends HBoxContainer

@onready var heartGuiClass = preload("res://gui/heart.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxHearts(maxH: int):
	for i in range(maxH):
		var heart = heartGuiClass.instantiate()
		add_child(heart)


func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	for i in range(currentHealth):
		hearts[i].update(true)
	
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
