ds_list_clear(entity_list);

var _cx = game_cam0.follow_x,
	_cy = game_cam0.follow_y;
	
entity_count = collision_circle_list(_cx, _cy, C_ENTITY_CULL_DISTANCE, __entity, true, true, entity_list, false);
game_state();