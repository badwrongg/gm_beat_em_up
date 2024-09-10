// A quick and dirty menu.  Needs cleaned up and other things.

var _scale = get_gui_dimensions()[e_gui_dimension.scale],
	_th = string_height("H") * _scale,
	_width  = menu_width * _scale,
	_height = _th * menu_count;

image_xscale = _width / nine_center_width;
image_yscale = _height / nine_center_height;
var _dy = bbox_top; 

// Select menu item
menu_selection = range_wrap(menu_selection, (keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"))), menu_count);	
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space))
	menu_items[menu_selection].execute();

// Draw sprite and menu labels
draw_self();

for (var _i = 0; _i < menu_count; _i++)
{
	draw_text_transformed(bbox_left, _dy, menu_items[_i].label, _scale, _scale, 0);
	_dy += _th;
}

draw_text_transformed_color(
	bbox_left, bbox_top + _th * menu_selection, 
	menu_items[menu_selection].label, 
	_scale, _scale, 0,
	c_yellow, c_yellow, c_yellow, c_yellow, 1
);