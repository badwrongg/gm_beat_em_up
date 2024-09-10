// Instance related functions

function instance_draw_self()
{
	draw_sprite_ext(sprite_index, image_index, x_draw, y_draw, image_xscale, image_yscale, image_angle, image_blend, image_alpha);	
}

function get_collision_hitbox()
{
	// A static sensor object used for hitbox checks
	static _hitbox = instance_create_depth(0, 0, 0, __collision_hitbox);
	return _hitbox;
}

function instance_hitbox_list(_x, _y, _image_xscale, _image_yscale, _mask_index, _object, _list, _ordered)
{
	// A hitbox check that uses the static hitbox sensor
	static _hitbox = get_collision_hitbox();
	
	with (_hitbox)
	{
		image_xscale = _image_xscale;
		image_yscale = _image_yscale;
		mask_index   = _mask_index;
		x			 = _x;
		y			 = _y;
		
		return instance_place_list(_x, _y, _object, _list, _ordered);
	}
}

function get_collision_hitbox_center()
{
	// Returns (cheaply) the center of the static hitbox sensor object
	static _hitbox = get_collision_hitbox();
	return [(_hitbox.bbox_right + _hitbox.bbox_left) >> 1, (_hitbox.bbox_top + _hitbox.bbox_bottom) >> 1];
}