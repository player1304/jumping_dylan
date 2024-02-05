extends Node2D

signal player_scored

var roll_speed = 100


func _physics_process(delta):
	self.position.x -= delta * roll_speed
	
	if self.position.x <= -16:
		#print("delete obstacle")
		call_deferred("queue_free")
		


func _on_scoring_area_body_entered(body):
	if body.name == "Player":
		emit_signal("player_scored")
		#print("Player scored")
