extends Node2D

#Set these to modulate color
export(float, 1) var red = 1.0
export(float, 1) var green = 1.0
export(float, 1) var blue = 1.0


var newShader = preload("res://ScreenOutline.shader")


func _ready():
	var newMaterial = ShaderMaterial.new()
	newMaterial.set_shader(newShader)
	newMaterial.set_shader_param("modulate_color", Vector3(red, green, blue))
	newMaterial.set_shader_param("outline_diagonals", true)

	$Shape.set_material(newMaterial)


#	$Shape.ma
#	$Shape.material.set_shader_param("modulateColor", Vector3(red, green, blue))
