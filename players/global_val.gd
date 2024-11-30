extends Node
enum states {MOVE, DEATH, IDLE}
enum pets {CAT, DOG, BIRD, SNAKE, MOUSE}
enum sports {BASKETBALL, FOOTBALL, VOLLEYBALL, TENNIS, NULL}
enum weapons {STICK, AK47, GLOCK, RPG, MP5, SWORD, SPEAR, NULL}
enum stickers {SPEEDER, DAMAGER, HPER, NULL}
enum items {BASKETBALL, FOOTBALL, VOLLEYBALL, TENNIS, STICK, AK47, GLOCK, RPG, MP5, SWORD, SPEAR, NULL}
enum week {MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY,LASTDAY}
enum hands {LEFT, RIGHT}
const add_damage: int = 1 ## 武器伤害增加
const add_ammo: int = 5 ## 武器弹量增加
const sub_cd: float = 0.1 ## 武器冷却时间减少
const add_hp: int = 1 ## 血量增加
const add_speed: int = 10 ## 速度增加
var weekday = week.MONDAY
var early_eight = false
var last_day_early_eight = false
var jjh_count = 0
var points: int = 0
var new_day: bool = true
var place_visited = {
	"play_game" = false,
	"playground" = false,
	"work" = false,
	"library" = false,
	"exercise" = false,
	"school" = false,
	"movie" = false
}
var player = {
	"direction" = Vector2.ZERO, # 非可修改属性
	"position" = Vector2.ZERO, # 非可修改属性
	"state" = states.IDLE, # 非可修改属性
	"hp" = 20, # 血量
	"speed" = 150, # 速度
	"left_weapon" = weapons.NULL, # 左边武器栏
	"weapon" = weapons.NULL, # 中间武器栏
	"right_weapon" = weapons.NULL, # 右边武器栏
	"left_sticker" = false, # 左边饰品栏
	"mid_sticker" = false, # 中间饰品栏
	"right_sticker" = false, # 右边饰品栏
	"cat" = false, # 是否拥有猫咪
	"cat_weapon" = weapons.NULL, # 猫咪武器
	"dog" = false, # 是否拥有狗狗
	"dog_weapon" = weapons.NULL, # 狗狗武器
	"points" = 0, # 武器升级点数
	"basketball" = false,
	"football" = false,
	"tennisball" = false,
	"volleyball" = false,
	"left_weapon_enable" = false,
	"weapon_enable" = true,
	"right_weapon_enable" = false,
}
var stick = {
	"damage" = 1, # 伤害
	"number" = 1, # 一次性发射个数
	"cd" = 1, # 冷却时间
}
var ak47 = {
	"damage" = 3, # 伤害
	"number" = 30 # 弹量
}
var glock = {
	"damage" = 1, # 伤害
	"number" = 15 # 弹量
}
var rpg = {
	"damage" = 7, # 伤害
	"number" = 1 # 弹量
}
var mp5 = {
	"damage" = 1, # 伤害
	"number" = 50 # 弹量
}
var sword = {
	"damage" = 4 # 伤害
}
var spear = {
	"damage" = 4 # 伤害
}
var enemy = { ## 此处不生效，敌人属性在场景设置
	"hp": 25,
	"speed": 60,
	"damage": 1
}
var fly_enemy = {
	"hp": 30,
	"speed": 100,
	"damage": 1
}
var money = {
	"day" = 1,
	"night" = 0
}
var enemy_gen = {
	"enemy_per_batch": 20, ## 每一批次生成的敌人
	"total_batch": 5, ## 总批次
	"time_gap": 2, ## 敌人生成间隔时间
	"enemy_per_time": 4, ## 每次时间生成的敌人数
}
var properties = {
	"mobility" = 3,
	"stamina" = 1,
	"mood" = 1,
	"knowledge" = 1
}
########################################
var extra_prop_list = []
var weapons_list: Array[weapons] = [weapons.GLOCK] # 购买的武器
var sports_list: Array[sports] = [] # 购买的球类
var stickers_list: Array[stickers] = [] # 购买的饰品
var pets_list = []
var items_list = []

func add_day_money(amount: int) -> void:
	money["day"] += amount

func add_night_money(amount: int) -> void:
	money["night"] += amount

func minus_day_money(amount: int) -> void:
	money["day"] -= amount

func minus_night_money(amount: int) -> void:
	money["night"] -= amount

func add_property(prop: String, value: int) -> void:
	if properties[prop] + value > 10:
		properties[prop] = 10
	else:
		properties[prop] += value

func minus_property(prop: String, value: int) -> void:
	if properties[prop] - value < 0:
		properties[prop] = 0
	else:
		properties[prop] -= value

func add_extra_prop(prop) -> void:
	extra_prop_list.append(prop)

func add_weapon(weapon) -> void:
	weapons_list.append(weapon)

func add_pet(pet) -> void:
	pets_list.append(pet)
	#pets.append(pet)

func upgrade_weapon(weapon: weapons, attr: String) -> void:
	match weapon:
		weapons.STICK:
			match attr:
				"damage":
					stick["damage"] += add_damage
				"number":
					stick["number"] += 1
				"cd":
					stick["cd"] -= sub_cd
		weapons.AK47:
			match attr:
				"damage":
					ak47["damage"] += add_damage
				"number":
					ak47["number"] += add_ammo
		weapons.GLOCK:
			match attr:
				"damage":
					glock["damage"] += add_damage
				"number":
					glock["number"] += add_ammo
		weapons.RPG:
			match attr:
				"damage":
					rpg["damage"] += add_damage
				"number":
					rpg["number"] += add_ammo
		weapons.MP5:
			match attr:
				"damage":
					mp5["damage"] += add_damage
				"number":
					mp5["number"] += add_ammo
		weapons.SWORD:
			match attr:
				"damage":
					sword["damage"] += add_damage
		weapons.SPEAR:
			match attr:
				"damage":
					spear["damage"] += add_damage
		# TODO: 添加其他武器
func add_points():
	player["points"] += 1
	points += 1
func reset_weapons():
	stick["damage"] = 1
	stick["number"] = 1
	stick["cd"] = 1
	ak47["damage"] = 3
	ak47["number"] = 30
	glock["damage"] = 1
	glock["number"] = 15
	rpg["damage"] = 7
	rpg["number"] = 1
	mp5["damage"] = 1
	mp5["number"] = 50
	sword["damage"] = 4
	spear["damage"] = 4
	player["points"] = points
# TODO: 添加其他武器
var save_path = "user://data.sav"
func save_game():
	var data = {
		"player": player,
		"money": money,
		"properties": properties,
		"extra_prop_list": extra_prop_list,
		"weapons_list": weapons_list,
		"pets_list": pets_list,
		"points": points,
		"stick": stick,
		"ak47": ak47,
		"glock": glock,
		"rpg": rpg,
		"mp5": mp5,
		"sword": sword,
		"spear": spear,
	}
	var json = JSON.stringify(data)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(json)
	file.close()
func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	var json = file.get_as_text()
	file.close()
	var data = JSON.parse_string(json) as Dictionary
	player = data["player"]
	money = data["money"]
	properties = data["properties"]
	extra_prop_list = data["extra_prop_list"]
	weapons_list = data["weapons_list"]
	pets_list = data["pets_list"]
	points = data["points"]
	stick = data["stick"]
	ak47 = data["ak47"]
	glock = data["glock"]
	rpg = data["rpg"]
	mp5 = data["mp5"]
	sword = data["sword"]
	spear = data["spear"]

func init() -> void:
	reset_weapons()
	player["left_sticker"] = false
	player["right_sticker"] = false
	player["mid_sticker"] = false
	player["left_weapon_enable"] = false


func random_zero_mobility_message()->String:
	var messages = ["累了","摆了","不想动了","没劲儿了","没有行动力了"]
	return messages[randi() % messages.size()]

func random_no_money_message()->String:
	var messages = ["钱不够","没钱了","没钱购买","没米了","实在不行打劫吧","真没米了/(ㄒoㄒ)/~~"]
	return messages[randi() % messages.size()]

func random_playground_dialog():
	var dialogs = []
	if place_visited["playground"] == false:
		dialogs.append("你来到了操场")
	if place_visited["playground"] == true:
		dialogs.append("你又来到了操场")
	var key = randi() % 2
	if key == 0:
		dialogs.append("今天操场上的人不多")
		dialogs.append("“还是我比较自律”")
		dialogs.append("你心想")
	if key == 1:
		dialogs.append("操场上有很多人在跑步")
		dialogs.append("你也加入了跑步的行列")
	dialogs.append("体质+1")
	dialogs.append("知识-1")
	dialogs.append("行动力-1")

	key = randi() % 10

	if key<=2:
		if player["dog"] == false:
			dialogs.append("你看见了一条狗")
			dialogs.append("他朝你摇了摇尾巴")
			dialogs.append("又绕着你转了一圈")
			dialogs.append("“今天美梦的素材有了”")
			dialogs.append("你心想")
			player["dog"] = true
	if key>=8:
		if player["cat"] == false:
			dialogs.append("你看见了一只猫")
			dialogs.append("走过来蹭了蹭你的腿")
			dialogs.append("你把它抱起来")
			dialogs.append("“什么时候我也能养只猫呢”")
			dialogs.append("作者想")
			dialogs.append("“今天的美梦素材有了”")
			dialogs.append("你心想")
			player["cat"] = true
	
	key = randi() % 2

	if key == 1:
		dialogs.append("你在操场上遇到了坤坤")
		dialogs.append("他是你的好朋友")
		var tem_key = randi() % 3
		if stickers.DAMAGER in stickers_list:
			tem_key = 3
			dialogs.append("坤坤在打篮球")
		if tem_key == 0:
			dialogs.append("坤坤在唱歌")
		if tem_key == 1:
			dialogs.append("坤坤在跳舞")
		if tem_key == 2:
			dialogs.append("坤坤在rap")
		
		if sports.BASKETBALL in sports_list && stickers.DAMAGER not in stickers_list:
			dialogs.append("坤坤想要借用你的篮球")
			dialogs.append("你同意了")
			stickers_list.append(stickers.DAMAGER)
			dialogs.append("你感觉和坤坤的关系加深了")
			dialogs.append("-------------------")
			dialogs.append("在梦里得到坤坤的助力了")
	
	return dialogs

func random_work_dialog():
	var dialogs = []
	if place_visited["work"] == false:
		dialogs.append("你来到了平时打工的店里")
	if place_visited["work"] == true:
		dialogs.append("你又来到了平时打工的店里")
	var key = randi() % 5
	if key == 0:
		dialogs.append("今天店里生意不错")
		dialogs.append("你忙碌了两个小时一会儿没停")
		dialogs.append("很累，但也没出什么差错")
		dialogs.append("店长很高兴多给你了你50块钱")
		add_day_money(50)
		dialogs.append("心情+1")
		dialogs.append("生活费+150")
	if key == 1:
		dialogs.append("今天店里生意不错")
		dialogs.append("你忙碌了两个小时一会儿没停")
		dialogs.append("你不小心打碎了一个盘子")
		dialogs.append("今天的工资少了25")
		minus_day_money(25)
		dialogs.append("心情+1")
		dialogs.append("生活费-25")
	if key == 2:
		dialogs.append("今天店里生意一般")
		dialogs.append("今天的打工很轻松")
		dialogs.append("大部分时间都在玩手机")
		dialogs.append("心情额外加1")
		add_property("mood", 1)
		dialogs.append("生活费+100")
		dialogs.append("心情+0")
	if key == 3:
		dialogs.append("今天店里生意一般")
		dialogs.append("今天的打工很轻松")
		dialogs.append("也是非常顺利的完成了今天的工作")
		dialogs.append("心情+1")
		dialogs.append("生活费+100")
	if key == 4:
		dialogs.append("今天店里生意不错")
		dialogs.append("来打工的学生也不少")
		dialogs.append("你趁机偷偷摸鱼")
		dialogs.append("心情额外加1")
		dialogs.append("心情+0")
		dialogs.append("生活费+100")
		add_property("mood", 1)

	dialogs.append("行动力-1")
	
	if weekday == week.THURSDAY:
		if place_visited["work"]:
			dialogs.append("“今天周四，你们再多干点活我请就你们吃肯德基”")
			dialogs.append("店长说")
			dialogs.append("生活费+50")
			dialogs.append("体质-1")
			add_day_money(50)
			minus_property("stamina", 1)
	return dialogs

func random_exercise_dialog():
	var dialogs = []
	if place_visited["exercise"] == false:
		dialogs.append("你来到了健身房")
	if place_visited["exercise"] == true:
		dialogs.append("你又来到了健身房")
	dialogs.append("学校免费的健身房是真香")
	var key = randi() % 5
	if key == 0:
		dialogs.append("你今天练了练核心力量")
	if key == 1:
		dialogs.append("你今天练了练肩膀")
	if key == 2:
		dialogs.append("你今天练了练腿")
	if key == 3:
		dialogs.append("你今天练了练腹部")
	if key == 4:
		dialogs.append("你今天练了练胳膊")
	
	key = randi() % 3
	if key == 0:
		dialogs.append("你今天的训练很有效果")
		dialogs.append("心情额外+1")
		add_property("mood", 1)
		dialogs.append("心情+2")
	if key == 1:
		dialogs.append("你今天的训练效果不错")
		dialogs.append("心情+1")
	if key == 2:
		dialogs.append("不小心把肌肉拉伤了")
		dialogs.append("心情额外减1")
		dialogs.append("心情+0")

	dialogs.append("体质+1")
	dialogs.append("行动力-2")

	return dialogs

func random_library_dialog():
	var dialogs = []
	if place_visited["library"] == false:
		dialogs.append("你来到了图书馆")
	if place_visited["library"] == true:
		dialogs.append("你又来到了图书馆")

	var key = randi() % 3
	if key == 0:
		dialogs.append("你在图书馆翻阅了一本书" + random_book())
		dialogs.append("不错的书")
		dialogs.append("知识+1")
	if key == 1:
		dialogs.append("你在图书馆自习了" + random_course())
		dialogs.append("很有收获")
		dialogs.append("知识+1")
	if key == 2:
		dialogs.append("你在图书馆看了一会儿书")
		dialogs.append("但你感觉什么都没学到")
		dialogs.append("知识额外减1")
		dialogs.append("心情+0")
		minus_property("knowledge", 1)
	if properties["knowledge"] >= 5:
		dialogs.append("学习使你进入了心流状态")
		dialogs.append("心情+1")
		add_property("mood", 1)

	dialogs.append("体质-1")
	dialogs.append("行动力-1")
	key = randi() % 2
	if key == 0:
		dialogs.append("你在图书馆遇到了顶真，她是你的好朋友")
		dialogs.append("她在图书馆里自习")
		dialogs.append("似乎被什么问题难到了")
		dialogs.append("你看了看这个题")
		dialogs.append("这题很难")
		if properties["knowledge"] >= 6:

			dialogs.append("但你轻松就解决了这个问题")
			if stickers.SPEEDER in stickers_list:
				dialogs.append("心情额外加1")
				dialogs.append("心情+1")
				add_property("mood", 1)

			if stickers.SPEEDER not in stickers_list:
				dialogs.append("你感觉和顶真的关系加深了")
				dialogs.append("-----------------------")
				dialogs.append("在梦里得到顶真的帮助了")
				stickers_list.append(stickers.SPEEDER)
		else :
			dialogs.append("你也不会")
			dialogs.append("你尴尬的笑笑")
			dialogs.append("离开了图书馆")
	return dialogs

func random_book():
	var books = ["《三体》","《红楼梦》","《活着》","《哈利波特》","《1984》","《三国演义》","《西游记》","《福尔摩斯》","《呐喊》","《朝花夕拾》","《悲惨世界》","《月亮与六便士》"]
	return books[randi() % books.size()]

func random_movie_dialog():
	var dialogs = []
	if place_visited["movie"] == false:
		dialogs.append("你来看电影了")
	if place_visited["movie"] == true:
		dialogs.append("你又来看电影了")

	var key = randi() % 5

	if key == 0:
		dialogs.append("你看了" + random_bad_movie())
		dialogs.append("真是个烂片")
		dialogs.append("心情额外减1")
		dialogs.append("心情+0")
		minus_property("mood", 1)
	if key == 3:
		dialogs.append("你看了" + random_nice_movie())
		dialogs.append("真是部优秀的电影")
		dialogs.append("心情额外加1")
		dialogs.append("心情+2")
		add_property("mood",1)
	if key == 4:
		dialogs.append("你看了" + random_nice_movie())
		dialogs.append("真是部优秀的电影")
		dialogs.append("心情额外加1")
		dialogs.append("这部电影传达的东西使你受益匪浅")
		dialogs.append("知识额外加1")
		dialogs.append("心情+2")
		dialogs.append("知识+1")
		add_property("mood",1)
		add_property("knowledge",1)
	if key == 1 || key == 2:
		dialogs.append("你看了一部中规中矩的电影")
		dialogs.append("心情+1")
	dialogs.append("生活费-50")
	dialogs.append("行动力-1")
	return dialogs

func random_bad_movie():
	var movies = ["环印度洋","北京堡垒","怪异博士2","电神4","大时代","648局"]
	return movies[randi() % movies.size()]

func random_nice_movie():
	var movies = ["穿越星际","肖电克的救赎","盗米空间","让子弹跑","回家地球3","我的名字","父愁者联盟","狗急啦"]
	return movies[randi() % movies.size()]

func random_school_dialog():
	var dialogs = []
	if place_visited["school"] == false:
		dialogs.append("你来上课了")
	if place_visited["school"] == true:
		dialogs.append("你又来上课了")
	
	dialogs.append("这节课上的是" + random_course())
	var key = randi() % 3
	if properties["knowledge"] >= 5:
		key = 4
	if key == 0:
		dialogs.append("你吃力地听完了")
		dialogs.append("心情-1")
		dialogs.append("知识+1")
		dialogs.append("行动力-1")
	if key == 1:
		dialogs.append("你居然听懂了")
		dialogs.append("心情-1")
		dialogs.append("知识+1")
		dialogs.append("行动力-1")
	if key == 2:
		dialogs.append("你听不懂")
		dialogs.append("你摆了")
		dialogs.append("你玩了一节课手机")
		dialogs.append("心情额外加2")
		dialogs.append("知识额外减1")
		add_property("mood", 2)
		minus_property("knowledge", 1)
		dialogs.append("知识+0")
		dialogs.append("心情+1")
		dialogs.append("行动力-1")
	if key == 4:
		dialogs.append("你听课毫无压力")
		dialogs.append("心情额外加2")
		add_property("mood", 2)
		dialogs.append("心情+1")
		dialogs.append("知识+1")
		dialogs.append("行动力-1")
	return dialogs

func random_course():
	var courses = ["英语课","近代史纲要","形势与政策","大学生心理健康","高等数学","线性代数","离散数学","概率论与数理统计","军事理论课","数据结构与算法","计算机导论","数据库系统概念","计算机组成原理","计算机系统设计","人工智能导论","机器学习","深度学习","编译原理","计算机网络"]
	return courses[randi() % courses.size()]

func add_day():
	if weekday == week.SUNDAY:
		weekday = week.MONDAY
	if weekday == week.MONDAY:
		weekday = week.TUESDAY
	if weekday == week.TUESDAY:
		weekday = week.WEDNESDAY
	if weekday == week.WEDNESDAY:
		weekday = week.THURSDAY
	if weekday == week.THURSDAY:
		weekday = week.FRIDAY
	if weekday == week.FRIDAY:
		weekday = week.SATURDAY
	if weekday == week.SATURDAY:
		weekday = week.SUNDAY
	if weekday==week.SUNDAY:
		weekday=week.LASTDAY
	place_visited["work"] = false
	place_visited["exercise"] = false
	place_visited["library"] = false
	place_visited["movie"] = false
	place_visited["game"] = false
	place_visited["school"] = false
	properties["mobility"] = 3
	last_day_early_eight = early_eight
	var key = randi() % 2
	if key == 0:
		early_eight = true
	if key == 1:
		early_eight = true
	new_day = true
func random_game_dialog():
	var dialogs = []
	if place_visited["game"] == false:
		dialogs.append("你开始打游戏了")
	if place_visited["game"] == true:
		dialogs.append("你又开始打游戏了")
	
	var key = randi() % 2
	
	if key == 0:
		dialogs.append("你打算今天玩一玩单机游戏")
		dialogs.append("你选择了" + random_single_player_game())
		dialogs.append("你很开心")
		dialogs.append("心情+2")
	
	if key == 1:
		dialogs.append("你打算今天玩一玩多人游戏")
		dialogs.append("你选择了" + random_multi_player_game())
		var tem_key = randi() % 3
		if tem_key == 0 || tem_key == 1:
			dialogs.append("队友很靠谱")
			dialogs.append("你很开心")
			dialogs.append("心情+2")
		if tem_key == 2:
			dialogs.append("队友很菜")
			dialogs.append("你被坑了")
			dialogs.append("心情额外减1")
			dialogs.append("心情+1")
			minus_property("mood", 1)
	dialogs.append("知识-1")
	dialogs.append("行动力-1")
	
	key = randi() % 4
	if key <= 2:
		dialogs.append("渣渣灰摇你打游戏")
		dialogs.append("他是你的好朋友")
		dialogs.append("跟你一样喜欢打游戏")
		dialogs.append("你们玩了很久" + random_single_player_game())
		dialogs.append("你感觉和他的关系加深了")
		jjh_count += 1
		if jjh_count >= 3 && stickers.HPER not in stickers_list:
			dialogs.append("你感觉和渣渣灰的关系变得很要好了")
			dialogs.append("------------------------")
			dialogs.append("在梦里得到渣渣灰的帮助了")
			stickers_list.append(stickers.HPER)
		dialogs.append("你感觉心情更好了")
		dialogs.append("心情+1")
		add_property("mood", 1)
	key = randi() % 3
	if key == 0:
		dialogs.append("你愿望单里的游戏新史低了")
		if money["day"] >= 50:
			dialogs.append("你买了心仪的游戏")
			dialogs.append("你很开心")
			dialogs.append("心情+1")
			add_property("mood",1)
			minus_day_money(50)
		else :
			dialogs.append("可惜你没钱买游戏")
			dialogs.append("你默默关掉了电脑")
	return dialogs

func random_single_player_game():
	var games = ["黑神话：悟空","P5R","以撒的结合","刺客信条","赛博朋克2077","空洞骑士","异星工厂","杀戮尖塔","死亡细胞","戴森球计划","undertale","泰坦陨落2","蔚蓝","巫师3","荒野大镖客2","那个游戏5","脑叶公司","都市：天际线","奥日","生化危机","生化奇兵","极乐迪斯科","杀手","光环","暖雪","上古卷轴5","逆转裁判","像素工厂","锈湖","星际拓荒","土豆兄弟","见证者","矮人要塞","极限竞速：地平线","命运石之门"]
	return games[randi()%games.size()]

func random_multi_player_game():
	var games = ["瓦洛兰特","CS2","守望先锋","怪物猎人","双人成行","王者荣耀","博德之门3","星露谷","泰拉瑞亚","我的世界","骗子酒馆","胡闹厨房","PAYDAY","第五人格","人类一败涂地","深岩银河","文明6","任天堂明星大乱斗"]
	return games[randi()%games.size()]

func _process(delta: float) -> void:
	if properties["stamina"] >= 4 && properties["stamina"] <= 6:
		player["left_weapon_enable"] = true
		player["right_weapon_enable"] = false
	if properties["stamina"] <= 3:
		player["left_weapon_enable"] = false
		player["right_weapon_enable"] = false
	if properties["stamina"] >= 7:
		player["left_weapon_enable"] = true
		player["right_weapon_enable"] = true
