extends CharacterBody2D

# get movement direction from input
# set velocity to movement direction
# move player
signal healthChanged
@export var speed: int = 35
@onready var animations = $AnimationPlayer
@onready var effects = $effects
@onready var hurtTimer = $hurtTimer
@export var maxHealth = 3
@export var knockbackPower: int = 500
@onready var hurtBox = $hurtBox
@export var inventory: Inventory
@onready var weapon = $weapon


var isHurt: bool = false

var currentHealth: int = maxHealth
var lastAnimDirection: String = "Down"
var isAttacking: bool = false


func _ready():
	effects.play("RESET")

func handleInput():
	var moveDirection = Input.get_vector('ui_left', "ui_right", "ui_up","ui_down")
	velocity = moveDirection*speed
	
	if Input.is_action_just_pressed("attack"):
		attack()
		
		
func attack():
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	weapon.enable()
	await animations.animation_finished
	weapon.disable()
	isAttacking = false
	
#func changeSpeed():
#	if Input.is_action_just_pressed("ui_shift"):
#		if speed == 35:
#			speed = 400
#		else:
#			speed = 35

	
func updateAnimation():
	if isAttacking: return 
	
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		animations.play("walk" + direction)
		lastAnimDirection = direction
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)
		
func _physics_process(delta):
	handleInput()
	move_and_slide()
	#changeSpeed()
	handleCollision()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false
	
func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
		
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_hurt_box_area_exited(area):
	pass
