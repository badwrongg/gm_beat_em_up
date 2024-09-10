if (!debug_on)
	exit;

draw_set_alpha(0.3);

if (draw_collision)
{
	with (__collider)
	{
		if (mask_index == sprite_index)
			draw_self();
		else
			draw_sprite(mask_index, 0, x, y);
	}
	
	with (__character)
		draw_sprite(mask_index, 0, x, y);
}

if (draw_combat)
{
	
	
	with (__hurtbox)
			draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_blue, c_blue, c_blue, c_blue, false);	
			
	with (__character)
		if (attack_active != C_CHARACTER_NO_ATTACK)
		{
			var _sx = x - sprite_xoffset,
				_sy = y_draw - sprite_yoffset;
			
			draw_rectangle_color(
				_sx + sprite_get_bbox_left(sprite_index) * image_xscale,
				_sy + sprite_get_bbox_top(sprite_index), 
				_sx + sprite_get_bbox_right(sprite_index) * image_xscale, 
				_sy + sprite_get_bbox_bottom(sprite_index), 
				c_red, c_red, c_red, c_red, false);	
		}

	
}

if (draw_navgrid)
{
	with (__collision_line_thick)
		draw_self();
	
	mp_grid_draw(global.navgrid);
	with (__enemy)
	{
		draw_path(ai_path, x, y, true);
		for (var _p = 0, _num = path_get_number(ai_path); _p < _num; _p++)
			draw_circle(path_get_point_x(ai_path, _p), path_get_point_y(ai_path, _p), 10, false);			
		
		draw_circle_color(safe_nav_x, safe_nav_y, 16, c_blue, c_blue, false);						
	}
	
	with (__player)
		draw_circle_color(safe_nav_x, safe_nav_y, 16, c_yellow, c_yellow, false);
}


draw_set_alpha(1);
	
draw_sprite(spr_cursor_arrow, 0, mouse_x, mouse_y);