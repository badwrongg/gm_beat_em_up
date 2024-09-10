var _fill = 0;

with (entity_player)
	_fill = hitpoints/hitpoints_max;

draw_sprite(sprite_index, 1, x, y);
draw_sprite_ext(sprite_index, 0, x, y, _fill, 1, 0, c_white, 1);
