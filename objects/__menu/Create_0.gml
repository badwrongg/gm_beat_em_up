event_inherited();

// A quick and dirty menu.  Needs cleaned up and other things.

nine = sprite_get_nineslice(sprite_index);

nine_center_height = sprite_get_height(sprite_index) - nine.top - nine.bottom;
nine_center_width  = sprite_get_width(sprite_index) - nine.left - nine.right;

menu_items = [];
event_user(0);
menu_count = array_length(menu_items);
menu_selection = 0;
menu_width = 0;

draw_set_font(fnt_gui_normal);

for (var _i = 0; _i < menu_count; _i++)
	menu_width = max(menu_width, string_width(menu_items[_i].label));
