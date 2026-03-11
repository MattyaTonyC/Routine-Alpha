//
cursor_sprite = s_cursor_menu_main

//
door_surface = noone
door_timer = 0
door_value = 0
settings_opened = false

//
buttons = [
	{ text:"Продолжить", func:function(){}, pressed:false },
	{ text:"Новая игра", func:function(){transition.target = r_house}, pressed:false },
	{ text:"Настройки", func:function(){menu_main.settings_opened = !menu_main.settings_opened}, pressed:false },
	{ text:"Выход", func:function(){transition.target = r_game_end}, pressed:false },
]
hover_prev = noone
