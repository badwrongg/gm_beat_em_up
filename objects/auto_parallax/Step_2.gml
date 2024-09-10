var _x = camera.x,
	_y = camera.y;
	
for (var _l = 0; _l < layer_count; _l++)
{
	var _id = layer_ids[_l];
	layer_x(_id, _x * layer_speeds_x[_l]);
	layer_y(_id, _y * layer_speeds_y[_l] + layer_offsets_y[_l]);
}