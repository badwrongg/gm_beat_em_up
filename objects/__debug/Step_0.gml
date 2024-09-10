if (keyboard_check_pressed(vk_f1))
{
	debug_on = !debug_on;
	
	if (debug_on)
	{
		show_debug_overlay(draw_overlay);	
	}
	else
	{
		show_debug_overlay(false);	
	}
}

if (!debug_on)
	exit;

if (keyboard_check_pressed(vk_f2))
	draw_collision = !draw_collision;
	
if (keyboard_check_pressed(vk_f3))
	draw_combat = !draw_combat;
	
if (keyboard_check_pressed(vk_f4))
	draw_navgrid = !draw_navgrid;
	
if (keyboard_check_pressed(vk_f10))
	room_restart();
		
if (mouse_check_button_pressed(mb_left))
{
	var _hurt = instance_position(mouse_x, mouse_y, __hurtbox);
	if (_hurt != noone)
		_hurt.receive_attack([1, 10, 10], id);
}