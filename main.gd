extends Node2D

var Obstacle = preload("res://obstacle.tscn")
var score : int = 0

func _ready():
	var p = $Player
	p.increment_score.connect(self.increment_score)

func _on_spawn_obstacle_timer_timeout():
	

	# spawn at (240,96)
	var o = Obstacle.instantiate()
	o.position.x = 240
	o.position.y = 96
	add_child(o)
	
	# decide if it has an upper box
	var upp = randi() % 2
	if upp == 0:
		var u = o.find_child("TopBlock")
		u.queue_free()
	
	# randomize when next block is coming out
	var new_wait_time : float = randf_range(0.8, 2)
	$SpawnObstacleTimer.wait_time = new_wait_time

func increment_score():
	score += 1
	$ScoreLabel.text = "Score: %s" % str(score)
