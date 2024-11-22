extends Resource
class_name PlayerData

enum States { MOVE, DEATH, IDLE }
enum Weapons { HAND, STICK }
enum Hands { LEFT, RIGHT }
@export var direction:Vector2=Vector2.ZERO
@export var left_weapon: Weapons = Weapons.HAND
@export var right_weapon: Weapons = Weapons.HAND
@export var acc: int = 2000 ## 加速度
@export var fri: int = 2000 ## 摩擦力
@export var speed: int = 300 ## 最大速度
@export var hp: int = 5 ## 生命值
@export var state:States=States.IDLE
