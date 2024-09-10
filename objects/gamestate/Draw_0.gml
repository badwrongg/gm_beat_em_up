/// @description Depth Sort Entities

// !!! This will be changed to a faster sorting algorithm...probably binary insertion

var _arr   = [],
	_count = 0,
	_id    = noone,
	_i     = 0;

for (_i = 0; _i < entity_count; _i++)
{
	_id = entity_list[| _i];
	for (var _c = 0; _c < _count; _c++)
		if (_arr[_c].bbox_bottom > _id.bbox_bottom)
			break;

	array_insert(_arr, _c, _id);
	_count++;
}

for (_i = 0; _i < C_PARTICLE_SYSTEM_COUNT; _i++)
{
	_id = particle_systems[_i];
	
	if (_id.bbox_bottom == 0) continue;
		
	for (var _c = 0; _c < _count; _c++)
		if (_arr[_c].bbox_bottom > _id.bbox_bottom)
			break;

	array_insert(_arr, _c, _id);
	_count++;
}

for (_i = 0; _i < _count; _i++)
	with (_arr[_i])
		draw_script();
