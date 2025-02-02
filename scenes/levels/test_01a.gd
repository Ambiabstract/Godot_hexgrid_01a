@tool
extends Node3D

func _init():
	print("_init")

func _ready():
	print("_ready")

func _enter_tree():
	print("_enter_tree")
	if Engine.is_editor_hint():
		print("if Engine.editor_hint")

func _notification(what):
	if what == NOTIFICATION_ENTER_TREE and Engine.is_editor_hint():
		print("Узел добавлен в дерево сцен (работает в редакторе).")
	if what == NOTIFICATION_READY:
		print("Узел готов к работе.")
