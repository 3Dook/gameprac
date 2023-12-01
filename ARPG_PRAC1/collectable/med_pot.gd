extends "res://collectable/collectable.gd"

@onready var animations = $AnimationPlayer

func collect(inventory: Inventory):
	animations.play("collected")
	await animations.animation_finished
	super(inventory) #call from the extends inheritance
