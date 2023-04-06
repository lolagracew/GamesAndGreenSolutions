extends Node2D

var fishInScene = []
var location = Vector2()
var x = 0
var currentFish 

var rightBoat

#func instanceFish():
#	$fishInstanceDelay.start(rand_range(0,2))

func instanceLeftBoat():
	var LeftBoat = preload("res://LeftBoatOnPath.tscn").instance()
	add_child(LeftBoat)
	$LeftBoatInstanceDelay.start(rand_range(10,25))

func instanceRightBoat():
	var RightBoat = preload("res://RightBoatOnPath.tscn").instance()
	add_child(RightBoat)
	$RightBoatInstanceDelay.start(rand_range(10,25))	
	
func instanceBottomBoat():
	var BottomBoat = preload("res://BottomBoatOnPath.tscn").instance()
	add_child(BottomBoat)
	$BottomBoatInstanceDelay.start(rand_range(10,25))	

func _ready():
	$LeftBoatInstanceDelay.start(rand_range(0,15))
	#$RightBoatInstanceDelay.start(rand_range(0,1))	
	$BottomBoatInstanceDelay.start(rand_range(0,1))	
	$fishInstanceDelay.start(rand_range(0,2))
	
func _on_LeftBoatInstanceDelay_timeout():
	instanceLeftBoat()

func _on_RightBoatInstanceDelay_timeout():
	instanceRightBoat()

func _on_BottomBoatInstanceDelay_timeout():
	instanceBottomBoat()

func _on_Area2D_area_entered(area):
	if(area.name == "BoatArea"):
		if(len(fishInScene) > 2):
			var i = len(fishInScene)
			
#			print("remove index")
#			print(i)
			
			fishInScene[i-1].queue_free()
			fishInScene.remove(i-1)
			
#			print("boat entered")
#			print(len(fishInScene))


func _on_NoFishArea_area_entered(area):
	if(area.name == "fishArea"):
		var i = fishInScene.find(area.get_parent())
		fishInScene.remove(i)
		area.get_parent().queue_free()	
		
#		print("bad area")
#		print(len(fishInScene))
	

func _on_fishInstanceDelay_timeout():
	randomize()
	
	var packedFishScene = [
	preload("res://EelFishInstance.tscn"),
	preload("res://OrangeFishInstance.tscn"),
	preload("res://greenFishInstance.tscn")	
	]
	
	var size  = get_viewport().get_visible_rect().size
	location.x = rand_range(0,size.x)
	location.y = rand_range(0,size.y)
	
	packedFishScene.shuffle()
	var fish = packedFishScene[0].instance()
	fish.position = location
	
	add_child(fish)
	currentFish = fish
	
	fishInScene.append(fish)
	x=x+1

#	print("new fish")
#	print(len(fishInScene))

